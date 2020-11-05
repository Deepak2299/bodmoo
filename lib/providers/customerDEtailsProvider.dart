import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetailsProvider extends ChangeNotifier {
  String phoneNumber;
  String customerName;
  List<String> address;
  String token;

  setCustomerDetails({@required String name, List<String> address, String token, String phone}) {
    this.customerName = name;
    this.address = address;
    this.token = token;
    this.phoneNumber = phone;
    notifyListeners();
  }

  String get getCustomerName => this.customerName;
  String get getCustomerPhone => this.phoneNumber;
  String get getToken => this.token;
  List<String> get getAddress => this.address;

}

String PREFS_LOGIN_KEY = 'BODMOO_LOGIN';
Future<bool> checkPrefsForLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool loginIn = await prefs.getBool(PREFS_LOGIN_KEY);
  if (loginIn != null)
    return loginIn;
  //NOT FOUND THEN FALSE
  else
    return false;
}

savePrefsForLogin({@required bool signIn}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(PREFS_LOGIN_KEY, signIn);

  print(prefs.getBool(PREFS_LOGIN_KEY).toString());
}
