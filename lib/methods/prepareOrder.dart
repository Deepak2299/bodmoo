import 'package:bodmoo/methods/post/postPlaceOrder.dart';
import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:provider/provider.dart';

Future<bool> prepareOrder(
    {@required AddressModel address,
    @required BuildContext context,
    @required orderId,
    @required transactionId}) async {
  OrderModel order = OrderModel(
    paymentTransactionId: transactionId,
    paymentType: "COD",
    orderItems: Provider.of<CartProvider>(context, listen: false).cartItems,
    addressModel: address,
    // orderId: orderId
  );
  return await postPlaceOrder(order: order, context: context);
}
