import 'dart:convert';

import 'package:bodmoo/methods/recents/loadRecents.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/partsModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/cartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetailsProvider extends ChangeNotifier {
  String phoneNumber;
  String customerName;
  String token;
  int addressIndex = -1;

  List<OrderItemModel> orderItems = [];
  setAddressINdex(int i) {
    addressIndex = i;
    notifyListeners();
  }

  setCustomerDetails({@required UserModel userModel}) {
    this.customerName = userModel.customerName;
    // this.addressList = userModel.;
    this.token = userModel.token;
    this.phoneNumber = userModel.customerMobile;
    notifyListeners();
  }

  addOrderItems({@required List<OrderItemModel> orderItemsList}) {
    orderItems = [];
    for (int i = 0; i < orderItemsList.length; i++) orderItems.add(orderItemsList[i]);
    // orderItemsList = orderItemsList;
    notifyListeners();
  }

  clearCustomerDetails() {
    phoneNumber = null;
    customerName = null;
    this.token = null;
    recentPartsList.clear();
    notifyListeners();
  }

  List<PartsModel> recentPartsList = [];

  addRecentParts(PartsModel part) async {
    print("recent list: " + recentPartsList.length.toString());
    bool c = false;
    int ind;
    for (int i = 0; i < recentPartsList.length; i++) {
      if (recentPartsList[i].id.contains(part.id)) {
        c = true;
        ind = i;
        break;
      }
    }
    if (!c) {
      recentPartsList.add(part);
      await SaveRecents(parts: recentPartsList);
      notifyListeners();
    } else {
      recentPartsList.removeAt(ind);
      recentPartsList.add(part);
      await SaveRecents(parts: recentPartsList);
      notifyListeners();
    }
  }
}

String PREFS_LOGIN_KEY = 'BODMOO_LOGIN';
String PREFS_CARTS_KEY = 'BODMOO_CARTS';
Future<bool> checkPrefsForLogin({@required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String user = await prefs.getString(PREFS_LOGIN_KEY);
  if (user != null) {
    UserModel userModel = UserModel.fromJson(user);
    Provider.of<CustomerDetailsProvider>(context, listen: false).setCustomerDetails(userModel: userModel);
    return true;
  }
  return false;
}

savePrefsForLogin({@required bool signIn, @required String user}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(PREFS_LOGIN_KEY, user);
}

clearPrefsForLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(PREFS_LOGIN_KEY);
  await prefs.remove(PREFS_CARTS_KEY);
}

savePrefsForCarts({@required List<OrderItemModel> orderItems}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // List<OrderItemModel> orderItems = Provider.of<ScreenProvider>(context, listen: false).cartItems;
  String carts =
      jsonEncode({"items": orderItems == null ? null : List<dynamic>.from(orderItems.map((x) => x.toMap()))});
  // print(carts);
  await prefs.setString(PREFS_CARTS_KEY, carts);
//  String cartStr = await prefs.getString(PREFS_CARTS_KEY);
//  print(cartStr);
}

fetchPrefsForCarts({@required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cartStr = await prefs.getString(PREFS_CARTS_KEY);
  print(cartStr);
  if (cartStr != null) {
    var carts = json.decode(cartStr);
    Provider.of<CartProvider>(context, listen: false).cartItems =
        carts["items"] == null ? null : List<OrderItemModel>.from(carts["items"].map((x) => OrderItemModel.fromMap(x)));
//    print(Provider.of<CartProvider>(context, listen: false).cartItems.length);
  }
}
