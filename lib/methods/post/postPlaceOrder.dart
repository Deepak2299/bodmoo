import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> postPlaceOrder(
    {@required OrderModel order, @required BuildContext context}) async {
//  Map<String, dynamic> body = order.toMap();
  print(order.toJson());
  var req = await http.post(POST_ADD_ORDER, body: order.toJson(), headers: {
    'Content-type': 'application/json',
    'x-auth-token':
        Provider.of<CustomerDetailsProvider>(context, listen: false).token
  });
  print(req.body);
  if (req.statusCode == 200) {
    //TODO: show MESSAGE

    return true;
  } else
    return false;
}
