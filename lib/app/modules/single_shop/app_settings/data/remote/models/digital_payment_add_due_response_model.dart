// To parse this JSON data, do
//
//     final digitalPaymentAddDueResponseModel = digitalPaymentAddDueResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';

DigitalPaymentAddDueResponseModel digitalPaymentAddDueResponseModelFromJson(
        String str) =>
    DigitalPaymentAddDueResponseModel.fromJson(json.decode(str));
DigitalPaymentAddDueResponseModel digitalPaymentAddDueResponseModelFromRawJson(
        dynamic json) =>
    DigitalPaymentAddDueResponseModel.fromJson(json);

String digitalPaymentAddDueResponseModelToJson(
        DigitalPaymentAddDueResponseModel data) =>
    json.encode(data.toJson());

class DigitalPaymentAddDueResponseModel {
  DigitalPaymentAddDueResponseModel({
    this.code,
    this.message,
    this.due,
    this.url,
  });

  int code;
  String message;
  Due due;
  String url;

  DigitalPaymentAddDueResponseModel copyWith({
    int code,
    String message,
    Due due,
    String url,
  }) =>
      DigitalPaymentAddDueResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        due: due ?? this.due,
        url: url ?? this.url,
      );

  factory DigitalPaymentAddDueResponseModel.fromJson(
          Map<String, dynamic> json) =>
      DigitalPaymentAddDueResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        due: json["due"] == null ? null : Due.fromJson(json["due"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "due": due == null ? null : due.toJson(),
        "url": url == null ? null : url,
      };
}
