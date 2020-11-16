import 'dart:convert';

import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<List<dynamic>> getAddress({
  @required String PhNo,
  @required BuildContext context,
}) async {
  List<dynamic> addresses = [];
  var req = await http.get(GET_ADDRESS_URL + PhNo, headers: {
    'Content-type': 'application/json',
    'x-auth-token':
        Provider.of<CustomerDetailsProvider>(context, listen: false).token
  });
  if (req.statusCode != 200) {
//    ScreenErrorData.subCatgError = jsonDecode(req.body)['message'];
  } else
//    ScreenErrorData.subCatgError = '';
    addresses = json.decode(req.body)["output"];
  print(req.body);
  return addresses;
}
