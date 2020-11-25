import 'dart:convert';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> editAddress({
  @required String token,
  @required AddressModel addressModel,
  @required String mobile,
  @required int addressIndex,
}) async {
  Map<String, dynamic> body = {
    "mobile": mobile,
    "address": addressModel.toMap(),
  };

  // var req = await http.post(
  //   EDIT_ADDRESS_URL,
  //   headers: {'Content-type': 'application/json', 'x-auth-token': token},
  //   body: jsonEncode(body),
  // );
  // print(req.body);
  // if (req.statusCode == 200) {
  return true;
  //   //TODO: DECODE USER MODEL
  // } else
  //   return false;
}
