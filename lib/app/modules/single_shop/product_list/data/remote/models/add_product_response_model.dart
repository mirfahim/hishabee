// To parse this JSON data, do
//
//     final addProductResponseModel = addProductResponseModelFromJson(jsonString);

import 'dart:convert';

import 'attribute_response_model.dart';
import 'product_response_model.dart';

AddProductResponseModel addProductResponseModelFromJson(String str) =>
    AddProductResponseModel.fromJson(json.decode(str));
AddProductResponseModel addProductResponseModelFromRawJson(dynamic json) {
  print("my add product response is : $json");
  return AddProductResponseModel.fromJson(json);
}

String addProductResponseModelToJson(AddProductResponseModel data) =>
    json.encode(data.toJson());

class AddProductResponseModel {
  AddProductResponseModel({
    this.code,
    this.message,
    this.product,
    this.attribute,
  });

  int code;
  String message;
  Product product;
  List<Attribute> attribute;

  AddProductResponseModel copyWith({
    int code,
    String message,
    Product product,
    List<Attribute> attribute,
  }) =>
      AddProductResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        product: product ?? this.product,
        attribute: attribute ?? this.attribute,
      );

  factory AddProductResponseModel.fromJson(Map<String, dynamic> json) =>
      AddProductResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        product: json["shop_product"] == null
            ? null
            : Product.fromJson(json["shop_product"]),
        attribute: json["attribute"] == null
            ? null
            : List<Attribute>.from(
                json["attribute"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "shop_product": product == null ? null : product.toJson(),
        "attribute": attribute == null
            ? null
            : List<dynamic>.from(attribute.map((x) => x.toJson())),
      };
}
