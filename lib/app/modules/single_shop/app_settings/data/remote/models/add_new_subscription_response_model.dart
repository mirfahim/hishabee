// To parse this JSON data, do
//
//     final addNewSubscriptionResponseModel = addNewSubscriptionResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_item_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_model.dart';

AddNewSubscriptionResponseModel addNewSubscriptionResponseModelFromJson(
        String str) =>
    AddNewSubscriptionResponseModel.fromJson(json.decode(str));
AddNewSubscriptionResponseModel addNewSubscriptionResponseModelFromRawJson(
        dynamic json) =>
    AddNewSubscriptionResponseModel.fromJson(json);

String addNewSubscriptionResponseModelToJson(
        AddNewSubscriptionResponseModel data) =>
    json.encode(data.toJson());

class AddNewSubscriptionResponseModel {
  AddNewSubscriptionResponseModel({
    this.code,
    this.message,
    this.shop,
    this.subscription,
    this.subscriptionItem,
  });

  int code;
  String message;
  Shop shop;
  Subscription subscription;
  SubscriptionItem subscriptionItem;

  AddNewSubscriptionResponseModel copyWith({
    int code,
    String message,
    Shop shop,
    Subscription subscription,
    SubscriptionItem subscriptionItem,
  }) =>
      AddNewSubscriptionResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        shop: shop ?? this.shop,
        subscription: subscription ?? this.subscription,
        subscriptionItem: subscriptionItem ?? this.subscriptionItem,
      );

  factory AddNewSubscriptionResponseModel.fromJson(Map<String, dynamic> json) =>
      AddNewSubscriptionResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
        subscriptionItem: json["subscription item"] == null
            ? null
            : SubscriptionItem.fromJson(json["subscription item"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "shop": shop == null ? null : shop.toJson(),
        "subscription": subscription == null ? null : subscription.toJson(),
        "subscription item":
            subscriptionItem == null ? null : subscriptionItem.toJson(),
      };
}
