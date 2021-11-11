// To parse this JSON data, do
//
//     final updateProductResponseModel = updateProductResponseModelFromJson(jsonString);

import 'dart:convert';

import 'product_response_model.dart';

UpdateProductResponseModel updateProductResponseModelFromJson(dynamic str) =>
    UpdateProductResponseModel.fromJson(str);

String updateProductResponseModelToJson(UpdateProductResponseModel data) =>
    json.encode(data.toJson());

class UpdateProductResponseModel {
  UpdateProductResponseModel({
    this.code,
    this.message,
    this.product,
    this.attribute,
  });

  int code;
  String message;
  Product product;
  List<dynamic> attribute;

  factory UpdateProductResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProductResponseModel(
        code: json["code"],
        message: json["message"],
        product: Product.fromJson(json["product"]),
        attribute: List<dynamic>.from(json["attribute"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "product": product.toJson(),
        "attribute": List<dynamic>.from(attribute.map((x) => x)),
      };
}
