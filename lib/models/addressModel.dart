import 'dart:convert';

class AddressModel {
  AddressModel({
    this.id,
    this.customerName,
    this.customerMobile,
    this.pincode,
    this.state,
    this.city,
    this.houseno,
    this.roadname,
  });

  String id;
  String customerName;
  String customerMobile;
  String pincode;
  String state;
  String city;
  String houseno;
  String roadname;

  factory AddressModel.fromJson(String str) => AddressModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        // id: json["_id"] == null ? null : json["_id"],
        customerName: json["customer_name"] == null ? null : json["customer_name"],
        customerMobile: json["customer_mobile"] == null ? null : json["customer_mobile"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        houseno: json["houseno"] == null ? null : json["houseno"],
        roadname: json["roadname"] == null ? null : json["roadname"],
      );

  Map<String, dynamic> toMap() => {
        // "_id": id == null ? null : id,
        "customer_name": customerName == null ? null : customerName,
        "customer_mobile": customerMobile == null ? null : customerMobile,
        "pincode": pincode == null ? null : pincode,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "houseno": houseno == null ? null : houseno,
        "roadname": roadname == null ? null : roadname,
      };
}
