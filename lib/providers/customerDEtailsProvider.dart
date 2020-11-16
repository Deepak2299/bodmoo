import 'dart:convert';

import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetailsProvider extends ChangeNotifier {
  String phoneNumber;
  String customerName;
  String token;

  String deliveryAddress;
  List<OrderItemModel> items;
  List<String> addressList;

  setCustomerDetails({@required UserModel userModel}) {
    this.customerName = userModel.customerName;
    // this.addressList = userModel.;
    this.token = userModel.token;
    this.phoneNumber = userModel.customerMobile;
    notifyListeners();
  }

  addAddress({@required String address}) {
    addressList.add(address);
    notifyListeners();
  }

  setName({@required String name}) {
    this.customerName = name;
    notifyListeners();
  }

  setAddress({@required String address}) {
    print(address);
    this.deliveryAddress = address;
    notifyListeners();
  }

  addOrder({@required List<OrderItemModel> orderItems}) {
    items = orderItems;
    notifyListeners();
  }

  String get getCustomerName => this.customerName;
  String get getCustomerPhone => this.phoneNumber;
  String get getToken => this.token;
  List<String> get getAddress => this.addressList;
  String get getDeliveryAddress => this.deliveryAddress;
}

String PREFS_LOGIN_KEY = 'BODMOO_LOGIN';
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
}
