import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<bool> deleteAddress({@required String phNo, @required AddressId}) async {
  print(DELETE_ADDRESS_URL + '/${phNo}/${AddressId}');
  var req = await http.delete(DELETE_ADDRESS_URL + '${phNo}/${AddressId}');
  print(req.body);
  switch (req.statusCode) {
    case 200:
      return true;
      break;
    default:
      return false;
  }
}
