// To parse this JSON data, do
//
//     final createShopResponse = createShopResponseFromJson(jsonString);

import 'dart:convert';

import 'get_all_shop_response_model.dart';

CreateShopResponseModel createShopResponseModelFromJson(String str) =>
    CreateShopResponseModel.fromJson(json.decode(str));

CreateShopResponseModel createShopResponseModelFromRawJson(dynamic json) =>
    CreateShopResponseModel.fromJson(json);

String createShopResponseToJson(CreateShopResponseModel data) =>
    json.encode(data.toJson());

class CreateShopResponseModel {
  CreateShopResponseModel({
    this.code,
    this.message,
    this.shop,
  });

  int code;
  String message;
  Shop shop;

  CreateShopResponseModel copyWith({
    int code,
    String message,
    Shop shop,
  }) =>
      CreateShopResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        shop: shop ?? this.shop,
      );

  factory CreateShopResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateShopResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "shop": shop == null ? null : shop.toJson(),
      };
}
