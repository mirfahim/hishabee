// To parse this JSON data, do
//
//     final getAllMessagePackageModel = getAllMessagePackageModelFromJson(jsonString);

import 'dart:convert';

List<GetAllMessagePackageModel> getAllMessagePackageModelFromJson(String str) =>
    List<GetAllMessagePackageModel>.from(
        json.decode(str).map((x) => GetAllMessagePackageModel.fromJson(x)));

String getAllMessagePackageModelToJson(List<GetAllMessagePackageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllMessagePackageModel {
  GetAllMessagePackageModel({
    this.id,
    this.description,
    this.smsAmount,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String description;
  int smsAmount;
  int price;
  dynamic createdAt;
  dynamic updatedAt;

  factory GetAllMessagePackageModel.fromJson(Map<String, dynamic> json) =>
      GetAllMessagePackageModel(
        id: json["id"],
        description: json["description"],
        smsAmount: json["sms_amount"],
        price: json["price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "sms_amount": smsAmount,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
