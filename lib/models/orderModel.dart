import 'dart:convert';

import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/userModel.dart';

class OrderModel {
  OrderModel({
    this.id,
    this.orderNumber,
    this.user,
    this.paymentType,
    this.paymentTransactionId,
    this.orderStatus,
    this.pinCode,
    this.orderItems,
    this.orderDate,
  });

  String id;
  String orderNumber;
  UserModel user;
  String paymentType;
  String paymentTransactionId;
  String orderStatus;
  String pinCode;
  List<OrderItemModel> orderItems;
  DateTime orderDate;

  factory OrderModel.fromJson(String str) => OrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["_id"] == null ? null : json["_id"],
        orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
        user: json["user"] == null ? null : UserModel.fromMap(json["user"]),
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        paymentTransactionId: json["paymentTransactionId"] == null ? null : json["paymentTransactionId"],
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        pinCode: json["pin_code"] == null ? null : json["pin_code"],
        orderItems: json["items"] == null
            ? null
            : List<OrderItemModel>.from(json["items"].map((x) => OrderItemModel.fromMap(x))),
        orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "orderNumber": orderNumber == null ? null : orderNumber,
        "user": user == null ? null : user.toMap(),
        "paymentType": paymentType == null ? null : paymentType,
        "paymentTransactionId": paymentTransactionId == null ? null : paymentTransactionId,
        "orderStatus": orderStatus == null ? null : orderStatus,
        "pin_code": pinCode == null ? null : pinCode,
        "items": orderItems == null ? null : List<dynamic>.from(orderItems.map((x) => x.toMap())),
        "order_date": orderDate == null ? null : orderDate.toIso8601String(),
      };
}
