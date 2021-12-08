// To parse this JSON data, do
//
//     final expenseAddForCategory = expenseAddForCategoryFromJson(jsonString);

import 'dart:convert';

List<ExpenseAddForCategory> expenseAddForCategoryModel(dynamic str) =>
    List<ExpenseAddForCategory>.from(
        str.map((x) => ExpenseAddForCategory.fromJson(x)));

ExpenseAddForCategory expenseAddForCategoryFromJson(String str) =>
    ExpenseAddForCategory.fromJson(json.decode(str));

String expenseAddForCategoryToJson(ExpenseAddForCategory data) =>
    json.encode(data.toJson());

class ExpenseAddForCategory {
  ExpenseAddForCategory({
    this.code,
    this.message,
    this.expense,
  });

  int code;
  String message;
  Expense expense;

  factory ExpenseAddForCategory.fromJson(Map<String, dynamic> json) =>
      ExpenseAddForCategory(
        code: json["code"],
        message: json["message"],
        expense: Expense.fromJson(json["Expense"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "Expense": expense.toJson(),
      };
}

class Expense {
  Expense({
    this.userId,
    this.shopId,
    this.type,
    this.purpose,
    this.amount,
    this.image,
    this.details,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int userId;
  int shopId;
  String type;
  String purpose;
  String amount;
  dynamic image;
  String details;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        userId: json["user_id"],
        shopId: json["shop_id"],
        type: json["type"],
        purpose: json["purpose"],
        amount: json["amount"],
        image: json["image"],
        details: json["details"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "shop_id": shopId,
        "type": type,
        "purpose": purpose,
        "amount": amount,
        "image": image,
        "details": details,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
