import 'dart:convert';

import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<List<PartsModel>> getAllParts() async {
  List<PartsModel> partsModel = [];

  var req = await http
      .get(GET_ALL_CAR_PART_URL, headers: {'Content-type': 'application/json'});
  print(req.body);

  if (req.statusCode != 200) {
//    ScreenErrorData.partsError = jsonDecode(req.body)['message'];
  }
//    ScreenErrorData.partsError = '';
  else {
    List<dynamic> body = json.decode(req.body)["output"];

    print(" All parts" + body.length.toString());
    if (body.length > 0) {
      // partsModel = PartsModel.fromJson(body[0]);
//    print(body[0][""]);
      for (int i = 0; i < body.length; i++) {
        partsModel.add(PartsModel.fromMap(body[i]));
      }
    }
  }

  return partsModel;
}
