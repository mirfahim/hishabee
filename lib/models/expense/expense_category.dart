// To parse this JSON data, do
//
//     final expenseCategoryResponseModel = expenseCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

List<ExpenseCategoryResponseModel> expenseCategoryResponseModelFromModel(dynamic str) =>
    List<ExpenseCategoryResponseModel>.from(str.map((x) => ExpenseCategoryResponseModel.fromJson(x)));

List<ExpenseCategoryResponseModel> expenseCategoryResponseModelFromJson(
        String str) =>
    List<ExpenseCategoryResponseModel>.from(
        json.decode(str).map((x) => ExpenseCategoryResponseModel.fromJson(x)));

String expenseCategoryResponseModelToJson(
        List<ExpenseCategoryResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseCategoryResponseModel {
  ExpenseCategoryResponseModel({
    this.id,
    this.name,
    this.shopId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int shopId;
  DateTime createdAt;
  DateTime updatedAt;

  factory ExpenseCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      ExpenseCategoryResponseModel(
        id: json["id"],
        name: json["name"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shop_id": shopId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
