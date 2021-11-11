// To parse this JSON data, do
//
//     final expenseResponseModel = expenseResponseModelFromJson(jsonString);

import 'dart:convert';

List<ExpenseResponseModel> expenseResponseModelFromJson(String str) =>
    List<ExpenseResponseModel>.from(
        json.decode(str).map((x) => ExpenseResponseModel.fromJson(x)));
List<ExpenseResponseModel> expenseResponseModelFromRawJson(dynamic json) =>
    List<ExpenseResponseModel>.from(
        (json as List<dynamic>).map((x) => ExpenseResponseModel.fromJson(x)));

String expenseResponseModelToJson(List<ExpenseResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseResponseModel {
  ExpenseResponseModel({
    this.id,
    this.userId,
    this.shopId,
    this.type,
    this.purpose,
    this.details,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.time,
  });

  int id;
  int userId;
  int shopId;
  String type;
  String purpose;
  String details;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime time;

  ExpenseResponseModel copyWith({
    int id,
    int userId,
    int shopId,
    String type,
    String purpose,
    String details,
    int amount,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime time,
  }) =>
      ExpenseResponseModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        type: type ?? this.type,
        purpose: purpose ?? this.purpose,
        details: details ?? this.details,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        time: time ?? this.time,
      );

  factory ExpenseResponseModel.fromJson(Map<String, dynamic> json) =>
      ExpenseResponseModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        type: json["type"] == null ? null : json["type"],
        purpose: json["purpose"] == null ? null : json["purpose"],
        details: json["details"] == null ? null : json["details"],
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "type": type == null ? null : type,
        "purpose": purpose == null ? null : purpose,
        "details": details == null ? null : details,
        "amount": amount == null ? null : amount,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "time": time == null ? null : time.toIso8601String(),
      };
}
