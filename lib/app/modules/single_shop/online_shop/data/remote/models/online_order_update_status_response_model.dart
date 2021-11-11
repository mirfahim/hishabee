// To parse this JSON data, do
//
//     final onlineOrderUpdateResponse = onlineOrderUpdateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_response_model.dart';

OnlineOrderUpdateResponseModel onlineOrderUpdateResponseModelFromJson(
        String str) =>
    OnlineOrderUpdateResponseModel.fromJson(json.decode(str));

OnlineOrderUpdateResponseModel onlineOrderUpdateResponseModelFromRawJson(
        dynamic json) =>
    OnlineOrderUpdateResponseModel.fromJson(json);

String onlineOrderUpdateResponseModelToJson(
        OnlineOrderUpdateResponseModel data) =>
    json.encode(data.toJson());

class OnlineOrderUpdateResponseModel {
  OnlineOrderUpdateResponseModel({
    this.code,
    this.message,
    this.order,
  });

  int code;
  String message;
  OnlineOrder order;

  OnlineOrderUpdateResponseModel copyWith({
    int code,
    String message,
    OnlineOrder order,
  }) =>
      OnlineOrderUpdateResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        order: order ?? this.order,
      );

  factory OnlineOrderUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      OnlineOrderUpdateResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        order:
            json["order"] == null ? null : OnlineOrder.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "order": order == null ? null : order.toJson(),
      };
}
