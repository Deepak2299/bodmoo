import 'dart:convert';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OrderModel {
  OrderModel(
      {this.orderNumber,
      this.prepaid,
      this.paymentTransactionId,
      this.orderStatus,
      this.orderItems,
      this.orderDate,
      this.razorpayOrderId,
      this.addressModel});

  String orderNumber;
  bool prepaid;
  String paymentTransactionId;
  String orderStatus;
  String razorpayOrderId;
  List<OrderItemModel> orderItems;
  DateTime orderDate;
  AddressModel addressModel;

  factory OrderModel.fromJson(String str) => OrderModel.fromMap(json.decode(str));

  String toJson(BuildContext context) => json.encode(toMap(context));

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
        addressModel: json["userDetails"] == null ? null : AddressModel.fromMap(json["userDetails"]),
        razorpayOrderId: json["razorpayOrderId"] == null ? null : json["razorpayOrderId"],
        prepaid: json["prepaid"] == null ? null : json["prepaid"],
        paymentTransactionId: json["paymentTransactionId"] == null ? null : json["paymentTransactionId"],
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        orderItems: json["items"] == null
            ? null
            : List<OrderItemModel>.from(json["items"].map((x) => OrderItemModel.fromMap(x))),
        orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
      );

  Map<String, dynamic> toMap(BuildContext context) => {
        "mobile": Provider.of<CustomerDetailsProvider>(context, listen: false).phoneNumber,
        "userDetails": addressModel == null ? null : addressModel.toMap(),
        "prepaid": prepaid == null ? null : prepaid,
        "paymentTransactionId": paymentTransactionId == null ? null : paymentTransactionId,
        "razorpayOrderId": razorpayOrderId == null ? null : razorpayOrderId,
        "items": orderItems == null ? null : List<dynamic>.from(orderItems.map((x) => x.toMap())),
      };
}
