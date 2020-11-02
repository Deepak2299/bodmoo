import 'dart:convert';

import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:http/http.dart' as http;

Future<List<OrderModel>> getOrdersList() async {
  print(GET_ORDERS_LIST + '9435');
  var req = await http.get(GET_ORDERS_LIST + '9435');
  print(req.statusCode.toString());
  List<OrderModel> ordersList = List<OrderModel>();
  if (req.statusCode == 200) {
    print(req.body);
    List<dynamic> list = jsonDecode(req.body)['output'];
    for (int i = 0; i < list.length; i++) {
      ordersList.add(OrderModel.fromMap(list[i]));
    }
  }

  return ordersList;
}
