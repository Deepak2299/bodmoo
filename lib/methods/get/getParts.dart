import 'dart:convert';

import 'package:bodmoo/Screens/realMeat/screenData.dart';
import 'package:bodmoo/models/partsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

//Future<PartsModel> getParts({
//  @required String category,
//  @required String subCategory,
//  @required String brandName,
//  @required String vehicleName,
//  @required String modelName,
//  @required String year,
//}) async {
//  PartsModel partsModel = PartsModel(
//    details: [],
//    id: "",
//    category: category,
//    subCategory: subCategory,
//    carBrand: brandName,
//    carName: vehicleName,
//    carModel: modelName,
//    modelYear: year,
//  );
//  Map<String, dynamic> params = {"carName": vehicleName, "carModel": modelName};
//  String url = GET_CAR_PART_URL +
//      brandName +
//      '&' +
////      vehicleName +
////      '&' +
////      modelName +
////      '&' +
//      year +
//      '&' +
//      category +
//      '&' +
//      subCategory;
//  print(url);
//  var req = await http.post(url,
//      body: jsonEncode(params), headers: {'Content-type': 'application/json'});
//  print(req.body);
//
//  if (req.statusCode != 200) {
////    ScreenErrorData.partsError = jsonDecode(req.body)['message'];
//  }
////    ScreenErrorData.partsError = '';
//  else {
//    List<dynamic> body = json.decode(req.body)["output"];
//
//    print("parts" + body.length.toString());
//    if (body.length > 0) {
//      // partsModel = PartsModel.fromJson(body[0]);
////    print(body[0][""]);
//      partsModel.id = body[0]["_id"];
//      for (int i = 0; i < body[0]["details"].length; i++) {
//        partsModel.details.add(PartDetail.fromMap(body[0]["details"][i]));
//      }
//    }
//  }
//
//  return partsModel;
//}

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
    modelYear: year,
  );

//  Map<String, dynamic> params = {"carName": vehicleName, "carModel": modelName};

  Map<String, dynamic> params = {
    "category": category,
    "sub_category": subCategory,
    "car_brand": brandName,
    "model_year": year,
    "car_name": vehicleName,
    "car_model": modelName,
  };

  print("GET SPECF PART BODY" + jsonEncode(params));
  var req = await http.post('https://apicarparts.herokuapp.com/api/store/products/getSpecificParts',
      body: jsonEncode(params), headers: {'Content-type': 'application/json'});

  print(req.body);
  if (req.statusCode != 200) {
    ScreenErrorData.partsError = jsonDecode(req.body)['message'];
  }
//    ScreenErrorData.partsError = '';
  else {
    List<dynamic> body = json.decode(req.body)["output"];

    print(body);
    if (body.length > 0) {
      // partsModel = PartsModel.fromJson(body[0]);
      print(body[0][""]);
      partsModel.id = body[0]["_id"];
      for (int i = 0; i < body[0]["details"].length; i++) {
        partsModel.details.add(PartDetail.fromMap(body[0]["details"][i]));
      }
    }
  }
  return partsModel;
}
