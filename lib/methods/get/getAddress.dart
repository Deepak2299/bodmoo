import 'dart:convert';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/models/userModel.dart';

import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<AddressModel>> getAddress({
  @required String PhNo,
  @required String token,
}) async {
  List<dynamic> addresses = [];
  var req = await http.get(GET_ADDRESS_URL + PhNo,
      headers: {'Content-type': 'application/json', 'x-auth-token': token});
  UserModel userModel = new UserModel(address: []);
//  = UserModel(address: []);
  if (req.statusCode == 200) {
    userModel = UserModel.fromMap(jsonDecode(req.body)['output']);
  }

  return userModel.address;
}
