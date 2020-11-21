import 'dart:convert';

import 'package:bodmoo/models/addressModel.dart';
import 'package:bodmoo/models/orderItemModel.dart';
import 'package:bodmoo/models/userModel.dart';
import 'package:bodmoo/providers/customerDEtailsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OrderModel {
  OrderModel(
      {
      // this.id,
      this.orderNumber,
      this.paymentType,
      this.paymentTransactionId,
      this.orderStatus,
      this.orderItems,
      this.orderDate,
      this.addressModel});

  // String id;
  String orderNumber;
  String paymentType;
  String paymentTransactionId;
  String orderStatus;
  List<OrderItemModel> orderItems;
  DateTime orderDate;
  AddressModel addressModel;

  factory OrderModel.fromJson(String str) => OrderModel.fromMap(json.decode(str));

  String toJson(BuildContext context) => json.encode(toMap(context));

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        // id: json["_id"] == null ? null : json["_id"],
        orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
        addressModel: json["userDetails"] == null ? null : AddressModel.fromMap(json["userDetails"]),
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
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
        "paymentType": paymentType == null ? null : paymentType,
        "paymentTransactionId": paymentTransactionId == null ? null : paymentTransactionId,
        "items": orderItems == null ? null : List<dynamic>.from(orderItems.map((x) => x.toMap())),
      };
}
