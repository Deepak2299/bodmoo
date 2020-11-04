import 'dart:convert';

import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<bool> getUserDetailsOrLogin({@required String PhNo}) async {
  Map<String, String> body = {"mobile": PhNo};
  var req = await http.post(
    LOGIN_URL,
    headers: {'Content-type': 'application/json'},
    body: jsonEncode(body),
  );
  if (req.statusCode == 200) {
    return true;
    //TODO: DECODE USER MODEL
  } else
    return false;
}
