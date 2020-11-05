import 'package:bodmoo/methods/post/postPlaceOrder.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/ScreenProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> prepareOrder(
    {@required List<OrderItemModel> items, BuildContext context}) async {
  var rng = new Random();
  OrderModel order = OrderModel(
//    orderDate: DateTime.now(),
    user: UserModel(
      address: 'a99',
      customerName: 'prayant',
      customerMobile:
          Provider.of<CustomerDetailsProvider>(context, listen: false).phoneNumber,
      pinCode: '121003',
    ),
    paymentTransactionId: "152522" + rng.nextInt(1000).toString(),
    paymentType: "COD",
    orderItems: items,
  );
  return await postPlaceOrder(order: order);
}
