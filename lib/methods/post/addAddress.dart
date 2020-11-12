import 'dart:convert';

import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<bool> addAddress({
  @required String Name,
  @required String PhNo,
  @required String Addrees,
}) async {
  Map<String, String> body = {
    "user_name": Name,
    "mobile": PhNo,
    "address": Addrees
  };
  var req = await http.post(
    ADD_ADDRESS_URL,
    headers: {'Content-type': 'application/json'},
    body: jsonEncode(body),
  );
  print(body);
  if (req.statusCode == 200) {
    return true;
    //TODO: DECODE USER MODEL
  } else
    return false;
}
