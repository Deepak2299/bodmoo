import 'package:bodmoo/models/addressModel.dart';
import 'package:flutter/material.dart';

String IMAGE = 'assets/bike.png';
final Color flipkartBlue = new Color(0XFF2874f0);
final OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    gapPadding: 2,
    borderSide:
        BorderSide(width: 1.8, color: flipkartBlue, style: BorderStyle.solid));
final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    gapPadding: 2,
    borderSide: BorderSide(
        width: 1.8, color: Colors.redAccent, style: BorderStyle.solid));

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


prepareAddress({@required AddressModel addressModel}) {
  return addressModel.houseno +
      "," +
      addressModel.roadname +
      "," +
      addressModel.city +
      "," +
      addressModel.state +
      "," +
      addressModel.pincode;
}