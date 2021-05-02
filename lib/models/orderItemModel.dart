// To parse this JSON data, do
//
//     final itemOrderModel = itemOrderModelFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class OrderItemModel {
  OrderItemModel({
    @required this.id,
    @required this.brandName,
    @required this.vehicleName,
    @required this.vehicleModel,
    @required this.vehicleYear,
    @required this.partName,
    @required this.partPrice,
    @required this.orderQty,
    @required this.productImages,
  });

  String id;
  String brandName;
  String vehicleName;
  String vehicleModel;
  String vehicleYear;
  String partName;
  String partPrice;
  int orderQty;
  List<String> productImages = [];
  factory OrderItemModel.fromJson(String str) => OrderItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromMap(Map<String, dynamic> json) => OrderItemModel(
        id: json["part_id"] == null ? null : json["part_id"],
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        vehicleName: json["vehicle_name"] == null ? null : json["vehicle_name"],
        vehicleModel: json["vehicle_model"] == null ? null : json["vehicle_model"],
        vehicleYear: json["vehicle_year"] == null ? null : json["vehicle_year"],
        partName: json["part_name"] == null ? null : json["part_name"],
        partPrice: json["item_price"] == null ? null : json["item_price"],
        orderQty: json["quantity"] == null ? null : json["quantity"],
        productImages: json["productImages"] == null ? null : List<String>.from(json["productImages"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "part_id": id,
        "brand_name": brandName == null ? null : brandName,
        "vehicle_name": vehicleName == null ? null : vehicleName,
        "vehicle_model": vehicleModel == null ? null : vehicleModel,
        "vehicle_year": vehicleYear == null ? null : vehicleYear,
        "part_name": partName == null ? null : partName,
        "item_price": partPrice == null ? null : partPrice,
        "quantity": orderQty == null ? null : orderQty,
        "productImages": productImages == null ? null : List<dynamic>.from(productImages.map((x) => x)),
      };
}
