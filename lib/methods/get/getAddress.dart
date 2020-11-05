import 'dart:convert';

import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getAddress({
  @required String PhNo,
}) async {
  List<dynamic> addresses = [];
  var req = await http.get(GET_ADDRESS_URL + PhNo,
      headers: {'Content-type': 'application/json'});
  if (req.statusCode != 200) {
//    ScreenErrorData.subCatgError = jsonDecode(req.body)['message'];
  } else
//    ScreenErrorData.subCatgError = '';
    addresses = json.decode(req.body)["output"];

  return addresses;
}
