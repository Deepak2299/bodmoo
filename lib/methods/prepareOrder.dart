import 'package:bodmoo/methods/post/postPlaceOrder.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:provider/provider.dart';

Future<bool> prepareOrder({@required String address, @required BuildContext context}) async {
  var rng = new Random();
  OrderModel order = OrderModel(
    user: UserModel(
      address: address,
      customerName: Provider.of<CustomerDetailsProvider>(context, listen: false).customerName,
      customerMobile: Provider.of<CustomerDetailsProvider>(context, listen: false).phoneNumber,
    ),
    paymentTransactionId: "152522" + rng.nextInt(1000).toString(),
    paymentType: "COD",
    orderItems: Provider.of<CustomerDetailsProvider>(context, listen: false).items,
  );
  return await postPlaceOrder(order: order);
}
