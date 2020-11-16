import 'dart:convert';

import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<OrderModel>> getOrdersList({@required String PhNo}) async {
  print(GET_ORDERS_LIST + PhNo);
  var req = await http.get(
    GET_ORDERS_LIST + PhNo,
    headers: {'Content-type': 'application/json'},
  );
//  x-auth-token
  print(req.statusCode.toString());
  List<OrderModel> ordersList = List<OrderModel>();
  if (req.statusCode == 200) {
    print(req.body);
    List<dynamic> list = jsonDecode(req.body)['output'];
    for (int i = 0; i < list.length; i++) {
      ordersList.add(OrderModel.fromMap(list[i]));
    }
  }
  print(ordersList.length.toString());
  return ordersList;
}
