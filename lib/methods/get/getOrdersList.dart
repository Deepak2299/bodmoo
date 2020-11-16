import 'dart:convert';

import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<List<OrderModel>> getOrdersList(
    {@required String PhNo, @required BuildContext context}) async {
  print(GET_ORDERS_LIST + PhNo);

  var req = await http.get(GET_ORDERS_LIST + PhNo, headers: {
    'Content-type': 'application/json',
    'x-auth-token':
        Provider.of<CustomerDetailsProvider>(context, listen: false).token
  });
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
