import 'dart:convert';

import 'package:bodmoo/models/addressModel.dart';

class UserModel {
  UserModel({
    this.customerName,
    this.customerMobile,
    this.token,
    this.address,
  });

  String customerName;
  String customerMobile;
  String token;
  List<AddressModel> address;
  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        customerName: json["username"] == null ? null : json["username"],
        customerMobile: json["mobile"] == null ? null : json["mobile"],
        token: json["token"] == null ? null : json["token"],
        address: json["address"] == null
            ? null
            : List<AddressModel>.from(json["address"].map((x) => AddressModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "username": customerName == null ? null : customerName,
        "mobile": customerMobile == null ? null : customerMobile,
      };
}
