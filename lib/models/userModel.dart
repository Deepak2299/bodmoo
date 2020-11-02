import 'dart:convert';

class UserModel {
  UserModel({this.customerName, this.customerMobile, this.address, this.pinCode});

  String customerName;
  String customerMobile;
  String address;
  String pinCode;
  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        customerName: json["customerName"] == null ? null : json["customerName"],
        customerMobile: json["customerMobile"] == null ? null : json["customerMobile"],
        address: json["address"] == null ? null : json["address"],
        pinCode: json["pin_code"] == null ? null : json["pin_code"],
      );

  Map<String, dynamic> toMap() => {
        "customerName": customerName == null ? null : customerName,
        "customerMobile": customerMobile == null ? null : customerMobile,
        "address": address == null ? null : address,
        "pin_code": pinCode == null ? null : pinCode,
      };
}
