// To parse this JSON data, do
//
//     final addVariationResponseModel = addVariationResponseModelFromJson(jsonString);

import 'dart:convert';

import 'variation_model.dart';

AddVariationResponseModel addVariationResponseModelFromJson(String str) =>
    AddVariationResponseModel.fromJson(json.decode(str));
AddVariationResponseModel addVariationResponseModelFromRawJson(dynamic json) =>
    AddVariationResponseModel.fromJson(json);

String addVariationResponseModelToJson(AddVariationResponseModel data) =>
    json.encode(data.toJson());

class AddVariationResponseModel {
  AddVariationResponseModel({
    this.code,
    this.message,
    this.variation,
  });

  int code;
  String message;
  Variation variation;

  AddVariationResponseModel copyWith({
    int code,
    String message,
    Variation variation,
  }) =>
      AddVariationResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        variation: variation ?? this.variation,
      );

  factory AddVariationResponseModel.fromJson(Map<String, dynamic> json) =>
      AddVariationResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        variation: json["variation"] == null
            ? null
            : Variation.fromJson(json["variation"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "variation": variation == null ? null : variation.toJson(),
      };
}
