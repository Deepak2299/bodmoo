import 'dart:convert';

import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<bool> postPlaceOrder({@required OrderModel order}) async {
  Map<String, dynamic> body = order.toMap();
  var req = await http.post(POST_ADD_ORDER, body: body);
  if (req.statusCode == 200) {
    //TODO: show MESSAGE
    return true;
  } else
    return false;
}
