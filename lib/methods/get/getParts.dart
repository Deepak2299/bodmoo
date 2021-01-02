import 'dart:convert';

import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<PartsModel> getParts({
  @required String category,
  @required String subCategory,
  @required String brandName,
  @required String vehicleName,
  @required String modelName,
  @required String year,
}) async {
  PartsModel partsModel = PartsModel(
    details: [],
    id: "",
    category: category,
    subCategory: subCategory,
    carBrand: brandName,
    carName: vehicleName,
    carModel: modelName,
    modelYear: int.parse(year),
  );
  Map<String, dynamic> params = {"carName": vehicleName, "carModel": modelName};
  String url = GET_CAR_PART_URL +
      brandName +
      '&' +
//      vehicleName +
//      '&' +
//      modelName +
//      '&' +
      year +
      '&' +
      category +
      '&' +
      subCategory;
  print(url);
  var req = await http.post(url,
      body: jsonEncode(params), headers: {'Content-type': 'application/json'});
  print(req.body);

  if (req.statusCode != 200) {
//    ScreenErrorData.partsError = jsonDecode(req.body)['message'];
  }
//    ScreenErrorData.partsError = '';
  else {
    List<dynamic> body = json.decode(req.body)["output"];

    print("parts" + body.length.toString());
    if (body.length > 0) {
      // partsModel = PartsModel.fromJson(body[0]);
//    print(body[0][""]);
      partsModel.id = body[0]["_id"];
      for (int i = 0; i < body[0]["details"].length; i++) {
        partsModel.details.add(PartDetail.fromMap(body[0]["details"][i]));
      }
    }
  }

  return partsModel;
}
