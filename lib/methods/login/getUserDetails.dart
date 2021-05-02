import 'dart:convert';

//import 'dart:js';

import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> getUserDetailsOrLogin({@required String PhNo, BuildContext context}) async {
  PhNo = "8826173684";
  Map<String, String> body = {"mobile": PhNo};
  var req = await http.post(
    LOGIN_URL,
    headers: {'Content-type': 'application/json'},
    body: jsonEncode(body),
  );

  if (req.statusCode == 200) {
    Map<String, dynamic> result = json.decode(req.body)['output'];
    UserModel user = UserModel.fromMap(result);
    savePrefsForLogin(signIn: true, user: jsonEncode(result));
    Provider.of<CustomerDetailsProvider>(context, listen: false).setCustomerDetails(userModel: user);
    return true;
  } else
    return false;
}
