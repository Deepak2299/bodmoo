import 'dart:convert';

import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getVehiclesByBrand({
  @required String brandName,
}) async {
  List<dynamic> vehicles = [];

  var req = await http.get(GET_CARS_URL + brandName,
      headers: {'Content-type': 'application/json'});
  print(req.body);
  if (req.statusCode != 200) {
//    ScreenErrorData.vehicleError = jsonDecode(req.body)['message'];
  } else
//    ScreenErrorData.vehicleError = '';
    vehicles = json.decode(req.body)["output"];
  print(vehicles.length.toString());
  return vehicles;
}
