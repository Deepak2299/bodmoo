import 'dart:convert';

import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> addUser({
  @required String Name,
  @required String PhNo,
  @required String Addrees,
  @required BuildContext context,
}) async {
  Map<String, dynamic> body = UserModel(
    customerName: Name,
    customerMobile: PhNo,
    address: Addrees,
  ).toMap();
  var req = await http.post(
    SIGNUP_URL,
    headers: {'Content-type': 'application/json'},
    body: jsonEncode(body),
  );
  if (req.statusCode == 200) {
    Map<String, dynamic> result = json.decode(req.body)['output'];
    UserModel user = UserModel.fromMap(result);
    savePrefsForLogin(
      signIn: true,
      user: jsonEncode(result),
    );
    Provider.of<CustomerDetailsProvider>(context, listen: false).setCustomerDetails(userModel: user);
    return true;
  } else
    return false;
}
