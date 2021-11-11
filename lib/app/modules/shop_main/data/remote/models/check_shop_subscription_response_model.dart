// To parse this JSON data, do
//
//     final checkShopSubscription = checkShopSubscriptionFromJson(jsonString);

import 'dart:convert';

import 'get_all_shop_response_model.dart';

CheckShopSubscriptionResponseModel checkShopSubscriptionFromJson(String str) =>
    CheckShopSubscriptionResponseModel.fromJson(json.decode(str));

CheckShopSubscriptionResponseModel checkShopSubscriptionFromRawJson(
        dynamic json) =>
    CheckShopSubscriptionResponseModel.fromJson(json);

String checkShopSubscriptionToJson(CheckShopSubscriptionResponseModel data) =>
    json.encode(data.toJson());

class CheckShopSubscriptionResponseModel {
  CheckShopSubscriptionResponseModel({
    this.code,
    this.message,
    this.shop,
  });

  int code;
  String message;
  Shop shop;

  CheckShopSubscriptionResponseModel copyWith({
    int code,
    String message,
    Shop shop,
  }) =>
      CheckShopSubscriptionResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        shop: shop ?? this.shop,
      );

  factory CheckShopSubscriptionResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CheckShopSubscriptionResponseModel(
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
