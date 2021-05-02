import 'dart:convert';

import 'package:bodmoo/Screens/realMeat/screenData.dart';
import 'package:bodmoo/models/VarinatModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<VariantsModel>> getVariants({
  @required String Vehiclename,
}) async {
  print("GETTING VARIANTS for ${Vehiclename}");

  List<VariantsModel> variants = [];
  // "CB Shine/SP Shine"
  Map<String, String> b = {"car_name": Vehiclename};
  print(b);
  var req = await http.post(
    GET_VARIANTS_URL,
    body: jsonEncode(b),
    headers: {'Content-type': 'application/json'},
  );
  print("Variuants:" + req.body + req.statusCode.toString());
  if (req.statusCode != 200) {
    ScreenErrorData.modelError = jsonDecode(req.body)['message'];
  } else {
    var body = json.decode(req.body)["output"];
    for (int i = 0; i < body.length; i++) {
      variants.add(VariantsModel.fromJson(body[i]));
    }
  }
  return variants;
}
