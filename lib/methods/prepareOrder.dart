import 'package:bodmoo/methods/post/postPlaceOrder.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:provider/provider.dart';

Future<bool> prepareOrder({@required AddressModel address, @required BuildContext context}) async {
  var rng = new Random();
  OrderModel order = OrderModel(
    paymentTransactionId: "152522" + rng.nextInt(1000).toString(),
    paymentType: "COD",
    orderItems: Provider.of<CustomerDetailsProvider>(context, listen: false).items,
    addressModel: address,
  );
  return await postPlaceOrder(order: order, context: context);
}
