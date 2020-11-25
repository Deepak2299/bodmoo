import 'package:bodmoo/models/addressModel.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

String IMAGE = 'assets/bike.png';
final Color flipkartBlue = new Color(0XFF2874f0);
final OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    gapPadding: 2,
    borderSide: BorderSide(width: 1.8, color: flipkartBlue, style: BorderStyle.solid));
final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    gapPadding: 2,
    borderSide: BorderSide(width: 1.8, color: Colors.redAccent, style: BorderStyle.solid));

emailValidator(String email) {
  email = email.trim();
  if (email.isEmpty)
    return "Enter Email";
  else {
    if (!email.contains('@', 0)) {
      return 'Invalid Email';
    }
  }
}

pwdValidator(String pwd) {
  pwd = pwd.trim();
  if (pwd.isEmpty)
    return "Enter Password";
  else {
    if (pwd.length < 6) {
      return 'Minimum password length must be 6';
    }
  }
}

codeValidation(String code) {
  code = code.trim();
  if (code.isEmpty)
    return "Enter Country Code";
  else {
    if (code.length > 2 || code.length < 1) return "Check Country Code";
  }
}

String prepareAddress({@required AddressModel addressModel}) {
  return addressModel.houseno + "," + addressModel.roadname + "," + addressModel.city + "," + addressModel.state;
}

class LoadingWidget extends StatelessWidget {
  String msg;
  LoadingWidget({@required this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              msg ?? 'Loading',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 20),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
