// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

VariantsModel welcomeFromJson(String str) =>
    VariantsModel.fromJson(json.decode(str));

String welcomeToJson(VariantsModel data) => json.encode(data.toJson());

class VariantsModel {
  VariantsModel({
    this.modelName,
    this.manufactureYear,
  });

  String modelName;
  String manufactureYear;

  VariantsModel copyWith({
    String modelName,
    String manufactureYear,
  }) =>
      VariantsModel(
        modelName: modelName ?? this.modelName,
        manufactureYear: manufactureYear ?? this.manufactureYear,
      );

  factory VariantsModel.fromJson(Map<String, dynamic> json) => VariantsModel(
        modelName: json["model_name"],
        manufactureYear: json["manufacture_year"],
      );

  Map<String, dynamic> toJson() => {
        "model_name": modelName,
        "manufacture_year": manufactureYear,
      };
}
