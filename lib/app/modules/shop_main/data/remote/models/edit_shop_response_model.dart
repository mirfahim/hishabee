// To parse this JSON data, do
//
//     final createShopResponse = createShopResponseFromJson(jsonString);

import 'dart:convert';

import 'get_all_shop_response_model.dart';

EditShopResponseModel editShopResponseModelFromJson(String str) =>
    EditShopResponseModel.fromJson(json.decode(str));

EditShopResponseModel editShopResponseModelFromRawJson(dynamic json) =>
    EditShopResponseModel.fromJson(json);

String editShopResponseToJson(EditShopResponseModel data) =>
    json.encode(data.toJson());

class EditShopResponseModel {
  EditShopResponseModel({
    this.code,
    this.message,
    this.shop,
  });

  int code;
  String message;
  Shop shop;

  EditShopResponseModel copyWith({
    int code,
    String message,
    Shop shop,
  }) =>
      EditShopResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        shop: shop ?? this.shop,
      );

  factory EditShopResponseModel.fromJson(Map<String, dynamic> json) =>
      EditShopResponseModel(
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
