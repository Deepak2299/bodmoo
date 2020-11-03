import 'dart:convert';

import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<PartsModel> getPartById({@required String partId}) async {
  PartsModel partsModel;
  String url = GET_PART_BY_ID + partId;
//  print(url);
  var req = await http.get(url, headers: {'Content-type': 'application/json'});
  print(req.body);
  if (req.statusCode != 200) {
//    ScreenErrorData.partsError = jsonDecode(req.body)['message'];
  }
//    ScreenErrorData.partsError = '';
//  print(req.body);
  var body = json.decode(req.body)["output"];

  partsModel = PartsModel.fromMap(body);

//  print(body);
//  if (body.length > 0) {
//    // partsModel = PartsModel.fromJson(body[0]);
////    print(body[0][""]);
//    partsModel.id = body[0]["_id"];
//    for (int i = 0; i < body[0]["details"].length; i++) {
//      partsModel.details.add(PartDetail.fromMap(body[0]["details"][i]));
//    }
//  }

  return partsModel;
}
