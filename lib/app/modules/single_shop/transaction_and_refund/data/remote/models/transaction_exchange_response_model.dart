// To parse this JSON data, do
//
//     final transactionExchangeResponseModel = transactionExchangeResponseModelFromJson(jsonString);

import 'dart:convert';

import 'transaction_item_response_model.dart';
import 'transaction_model.dart';

TransactionExchangeResponseModel transactionExchangeResponseModelFromJson(
        String str) =>
    TransactionExchangeResponseModel.fromJson(json.decode(str));
TransactionExchangeResponseModel transactionExchangeResponseModelFromRawJson(
        dynamic json) =>
    TransactionExchangeResponseModel.fromJson(json);

String transactionExchangeResponseModelToJson(
        TransactionExchangeResponseModel data) =>
    json.encode(data.toJson());

class TransactionExchangeResponseModel {
  TransactionExchangeResponseModel({
    this.code,
    this.message,
    this.transaction,
    this.transactionItems,
  });

  int code;
  String message;
  Transactions transaction;
  List<TransactionItem> transactionItems;

  TransactionExchangeResponseModel copyWith({
    int code,
    String message,
    Transactions transaction,
    List<TransactionItem> transactionItems,
  }) =>
      TransactionExchangeResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        transaction: transaction ?? this.transaction,
        transactionItems: transactionItems ?? this.transactionItems,
      );

  factory TransactionExchangeResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TransactionExchangeResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        transaction: json["transaction"] == null
            ? null
            : Transactions.fromJson(json["transaction"]),
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
