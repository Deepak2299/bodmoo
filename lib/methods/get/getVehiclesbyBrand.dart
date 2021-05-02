import 'dart:convert';

import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getVehiclesByBrand({
  @required String brandName,
}) async {
  List<dynamic> vehicles = [];
  Map<String, String> b = {"brand": brandName};
  var req = await http.post(GET_CARS_URL, headers: {'Content-type': 'application/json'}, body: jsonEncode(b));
  print(req.body);
  if (req.statusCode != 200) {
//    ScreenErrorData.vehicleError = jsonDecode(req.body)['message'];
  } else
    vehicles = json.decode(req.body)["output"];
  return vehicles;
}
