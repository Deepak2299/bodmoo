import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> postPlaceOrder({@required OrderModel order, @required BuildContext context}) async {
  print(order.toJson(context));
  var req = await http.post(POST_ADD_ORDER, body: order.toJson(context), headers: {
    'Content-type': 'application/json',
    'x-auth-token': Provider.of<CustomerDetailsProvider>(context, listen: false).token
  });
  print("placed" + req.body);
  if (req.statusCode == 200) {
    //TODO: show MESSAGE
    print("success");
    Provider.of<CartProvider>(context, listen: false).clearCart();
    savePrefsForCarts(orderItems: Provider.of<CartProvider>(context, listen: false).cartItems);
    return true;
  } else
    return false;
}
