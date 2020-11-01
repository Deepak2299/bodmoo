// To parse this JSON data, do
//
//     final itemOrderModel = itemOrderModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class OrderItemModel {
  OrderItemModel({
//    @required this.id,
    @required this.partId,
    @required this.brandName,
    @required this.vehicleName,
    @required this.vehicleModel,
    @required this.vehicleYear,
    @required this.partName,
    @required this.totalPrice,
    @required this.orderQty,
  });

  String partId;
  String brandName;
  String vehicleName;
  String vehicleModel;
  String vehicleYear;
  String partName;
  String totalPrice;
  int orderQty;
  factory OrderItemModel.fromJson(String str) => OrderItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromMap(Map<String, dynamic> json) => OrderItemModel(
        partId: json["part_id"] == null ? null : json["part_id"],
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        vehicleName: json["vehicle_name"] == null ? null : json["vehicle_name"],
        vehicleModel: json["vehicle_model"] == null ? null : json["vehicle_model"],
        vehicleYear: json["vehicle_year"] == null ? null : json["vehicle_year"],
        partName: json["part_name"] == null ? null : json["part_name"],
        totalPrice: json["total_price"] == null ? null : json["total_price"],
        orderQty: json["total_quantity"] == null ? null : json["total_quantity"],
      );

  Map<String, dynamic> toMap() => {
        "part_id": partId == null ? null : partId,
        "brand_name": brandName == null ? null : brandName,
        "vehicle_name": vehicleName == null ? null : vehicleName,
        "vehicle_model": vehicleModel == null ? null : vehicleModel,
        "vehicle_year": vehicleYear == null ? null : vehicleYear,
        "part_name": partName == null ? null : partName,
        "total_price": totalPrice == null ? null : totalPrice,
        "total_quantity": orderQty == null ? null : orderQty,
      };
}
