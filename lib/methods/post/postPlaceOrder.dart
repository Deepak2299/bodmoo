import 'package:bodmoo/models/orderModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:bodmoo/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> postPlaceOrder(
    {@required OrderModel order, @required BuildContext context}) async {
  print(order.toMap(context).toString());

  var req =
      await http.post(POST_ADD_ORDER, body: order.toJson(context), headers: {
    'Content-type': 'application/json',
    'x-auth-token':
        Provider.of<CustomerDetailsProvider>(context, listen: false).token
  });
  print("placed" + req.body);
  if (req.statusCode == 200) {
    //TODO: show MESSAGE
    print("success");
    return true;
  } else
    return false;
}
