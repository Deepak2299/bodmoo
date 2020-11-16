import 'dart:convert';

import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> addAddress(
    {@required String Name,
    @required String PhNo,
    @required String Addrees,
    @required BuildContext context}) async {
  Map<String, String> body = {
    "user_name": Name,
    "mobile": PhNo,
    "address": Addrees
  };
  var req = await http.post(
    ADD_ADDRESS_URL,
    headers: {
      'Content-type': 'application/json',
      'x-auth-token':
          Provider.of<CustomerDetailsProvider>(context, listen: false).token
    },
    body: jsonEncode(body),
  );
  print(body);
  if (req.statusCode == 200) {
    return true;
    //TODO: DECODE USER MODEL
  } else
    return false;
}
