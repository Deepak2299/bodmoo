import 'package:bodmoo/methods/post/postPlaceOrder.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:flutter/cupertino.dart';

Future<bool> prepareOrder({@required List<OrderItemModel> items}) async {
  OrderModel orderModel = OrderModel(
    orderDate: DateTime.now(),
    user: UserModel(
      address: 'a99',
      customerName: 'prayant',
      customerMobile: '85662',
    ),
    paymentType: "COD",
    pinCode: '121003',
    orderItems: items,
  );
  return await postPlaceOrder(order: orderModel);
}
