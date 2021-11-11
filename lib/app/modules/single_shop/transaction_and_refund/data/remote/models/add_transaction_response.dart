// To parse this JSON data, do
//
//     final addTransactionResponseModel = addTransactionResponseModelFromJson(jsonString);

import 'dart:convert';

import 'transaction_item_response_model.dart';
import 'transaction_model.dart';

AddTransactionResponseModel addTransactionResponseModelFromJson(String str) =>
    AddTransactionResponseModel.fromJson(json.decode(str));
AddTransactionResponseModel addTransactionResponseModelFromRawJson(
        dynamic json) =>
    AddTransactionResponseModel.fromJson(json);

String addTransactionResponseModelToJson(AddTransactionResponseModel data) =>
    json.encode(data.toJson());

class AddTransactionResponseModel {
  AddTransactionResponseModel({
    this.code,
    this.message,
    this.transaction,
    this.transactionItems,
  });

  int code;
  String message;
  Transaction transaction;
  List<TransactionItem> transactionItems;

  AddTransactionResponseModel copyWith({
    int code,
    String message,
    Transaction transaction,
    List<TransactionItem> transactionItems,
  }) =>
      AddTransactionResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        transaction: transaction ?? this.transaction,
        transactionItems: transactionItems ?? this.transactionItems,
      );

  factory AddTransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      AddTransactionResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        transaction: json["transaction"] == null
            ? null
            : Transaction.fromJson(json["transaction"]),
        transactionItems: json["transaction_items"] == null
            ? null
            : List<TransactionItem>.from(json["transaction_items"]
                .map((x) => TransactionItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "transaction": transaction == null ? null : transaction.toJson(),
        "transaction_items": transactionItems == null
            ? null
            : List<dynamic>.from(transactionItems.map((x) => x.toJson())),
      };
}
