// To parse this JSON data, do
//
//     final onlineShopInfoResponseModel = onlineShopInfoResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';

OnlineShopInfoResponseModel onlineShopInfoResponseModelFromJson(String str) =>
    OnlineShopInfoResponseModel.fromJson(json.decode(str));
OnlineShopInfoResponseModel onlineShopInfoResponseModelFromRawJson(
        dynamic json) =>
    OnlineShopInfoResponseModel.fromJson(json);

String onlineShopInfoResponseModelToJson(OnlineShopInfoResponseModel data) =>
    json.encode(data.toJson());

class OnlineShopInfoResponseModel {
  OnlineShopInfoResponseModel({
    this.code,
    this.message,
    this.shop,
  });

  int code;
  String message;
  Shop shop;

  OnlineShopInfoResponseModel copyWith({
    int code,
    String message,
    Shop shop,
  }) =>
      OnlineShopInfoResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        shop: shop ?? this.shop,
      );

  factory OnlineShopInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      OnlineShopInfoResponseModel(
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
