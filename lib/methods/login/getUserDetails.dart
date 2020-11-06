import 'dart:convert';
//import 'dart:js';

import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> getUserDetailsOrLogin(
    {@required String PhNo, BuildContext context}) async {
  Map<String, String> body = {"mobile": PhNo};
  var req = await http.post(
    LOGIN_URL,
    headers: {'Content-type': 'application/json'},
    body: jsonEncode(body),
  );
  print(req.body);
  print(req.statusCode);

  if (req.statusCode == 200) {
    var result = json.decode(req.body);
    Provider.of<CustomerDetailsProvider>(context, listen: false)
        .setCustomerDetails(
            name: result["username"],
            phone: result["mobile"],
            token: result["token"],
            address: null);
    return true;
    //TODO: DECODE USER MODEL
  } else
    return false;
}
