import 'dart:convert';

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
  String address;
  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        customerName: json["username"] == null ? null : json["username"],
        customerMobile: json["mobile"] == null ? null : json["mobile"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": customerName == null ? null : customerName,
        "mobile": customerMobile == null ? null : customerMobile,
        "address": address == null ? null : address,
      };
}
