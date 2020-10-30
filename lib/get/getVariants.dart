import 'dart:convert';
import 'package:bodmoo/models/VarinatModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<VariantsModel>> getVariants({
  @required String Vehiclename,
}) async {
  List<VariantsModel> variants = [];
  print(GET_VARIANTS_URL + Vehiclename);
  var req = await http.get(GET_VARIANTS_URL + Vehiclename);
  print(req.body);
  if (req.statusCode != 200) {
//    ScreenErrorData.modelError = jsonDecode(req.body)['message'];
  }
//    ScreenErrorData.modelError = '';
  var body = json.decode(req.body)["output"];
  for (int i = 0; i < body.length; i++) {
    variants.add(VariantsModel.fromJson(body[i]));
  }
  return variants;
}
