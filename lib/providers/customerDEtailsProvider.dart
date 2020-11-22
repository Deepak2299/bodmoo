import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetailsProvider extends ChangeNotifier {
  String phoneNumber;
  String customerName;
  String token;

  List<OrderItemModel> items;

  setCustomerDetails({@required UserModel userModel}) {
    this.customerName = userModel.customerName;
    // this.addressList = userModel.;
    this.token = userModel.token;
    this.phoneNumber = userModel.customerMobile;
    notifyListeners();
  }

  addOrder({@required List<OrderItemModel> orderItems}) {
    items = orderItems;
    notifyListeners();
  }

  clearCustomerDetails() {
    phoneNumber = null;
    customerName = null;
    this.token = null;
    notifyListeners();
  }
}

String PREFS_LOGIN_KEY = 'BODMOO_LOGIN';
Future<bool> checkPrefsForLogin({@required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String user = await prefs.getString(PREFS_LOGIN_KEY);
  if (user != null) {
    UserModel userModel = UserModel.fromJson(user);
    Provider.of<CustomerDetailsProvider>(context, listen: false)
        .setCustomerDetails(userModel: userModel);
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
