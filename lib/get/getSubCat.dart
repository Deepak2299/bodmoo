import 'dart:convert';

import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getSubCategories({
  @required String catgName,
}) async {
  List<dynamic> subCatgs = [];
  var req = await http.get(GET_SUB_CATG_URL + catgName,
      headers: {'Content-type': 'application/json'});
  if (req.statusCode != 200) {
//    ScreenErrorData.subCatgError = jsonDecode(req.body)['message'];
  } else
//    ScreenErrorData.subCatgError = '';
    subCatgs = json.decode(req.body)["output"];

  return subCatgs;
}
