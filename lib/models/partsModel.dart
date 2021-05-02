// To parse this JSON data, do
//
//     final partsModel = partsModelFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class PartsModel {
  PartsModel({
    @required this.id,
    @required this.carBrand,
    @required this.carName,
    @required this.carModel,
    @required this.modelYear,
    @required this.category,
    @required this.subCategory,
    @required this.details,
  });

  String id;
  String carBrand;
  String carName;
  String carModel;
  String modelYear;
  String category;
  String subCategory;
  List<PartDetail> details;

  factory PartsModel.fromJson(String str) => PartsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PartsModel.fromMap(Map<String, dynamic> json) => PartsModel(
        id: json["_id"] == null ? '123' : json["_id"],
        carBrand: json["car_brand"] == null ? null : json["car_brand"],
        carName: json["car_name"] == null ? null : json["car_name"],
        carModel: json["car_model"] == null ? null : json["car_model"],
        modelYear: json["model_year"] == null ? null : json["model_year"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        details:
            json["details"] == null ? null : List<PartDetail>.from(json["details"].map((x) => PartDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        //    "_id": id == null ? null : id,
        "car_brand": carBrand == null ? null : carBrand,
        "car_name": carName == null ? null : carName,
        "car_model": carModel == null ? null : carModel,
        "model_year": modelYear == null ? null : modelYear,
        "category": category == null ? null : category,
        "sub_category": subCategory == null ? null : subCategory,
        "details": details == null ? null : List<dynamic>.from(details.map((x) => x.toMap())),
      };
}

class PartDetail {
  PartDetail({
    // @required this.id,
    @required this.partName,
    @required this.description,
    @required this.itemPrice,
    @required this.quantity,
    @required this.outOfStock,
    @required this.productImages,
  });

  // String id;
  String partName;
  String description;
  int itemPrice;
  int quantity;
  bool outOfStock;
  List<String> productImages = [];

  factory PartDetail.fromJson(String str) => PartDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PartDetail.fromMap(Map<String, dynamic> json) => PartDetail(
        // id: json["_id"] == null ? '123' : json["_id"],
        partName: json["part_name"] == null ? null : json["part_name"],
        description: json["description"] == null ? null : json["description"],
        itemPrice: json["item_price"] == null ? null : json["item_price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        outOfStock: json["outOfStock"] == null ? null : json["outOfStock"],
        productImages: json["productImages"] == null ? null : List<String>.from(json["productImages"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        // "_id": id == null ? '123' : id,
        "part_name": partName == null ? null : partName,
        "description": description == null ? null : description,
        "item_price": itemPrice == null ? null : itemPrice,
        "quantity": quantity == null ? null : quantity,
        "outOfStock": outOfStock,
        "productImages": productImages == null ? null : List<dynamic>.from(productImages.map((x) => x)),
      };
}
