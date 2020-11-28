import 'dart:convert';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<List<dynamic>> getBrands() async {
  List<dynamic> brands = [];
  var req = await http
      .get(GET_BRANDS_URL, headers: {'Content-type': 'application/json'});
  // if (req.statusCode == 200) brands = jsonDecode(req.body)['output'];
  if (req.statusCode != 200) {
//    ScreenErrorData.brandError = jsonDecode(req.body)['message'];
  } else
//    ScreenErrorData.brandError = '';
    brands = json.decode(req.body)["output"];
  return brands;
}