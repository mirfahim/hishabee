// To parse this JSON data, do
//
//     final digitalPaymentTransactionUrlResponseModel = digitalPaymentTransactionUrlResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';

DigitalPaymentResponseModel digitalPaymentResponseModelFromJson(String str) =>
    DigitalPaymentResponseModel.fromJson(json.decode(str));
DigitalPaymentResponseModel digitalPaymentResponseModelFromRawJson(
    dynamic json) {
  print("Json $json");
  return DigitalPaymentResponseModel.fromJson(json);
}

String digitalPaymentResponseModelToJson(DigitalPaymentResponseModel data) =>
    json.encode(data.toJson());

class DigitalPaymentResponseModel {
  DigitalPaymentResponseModel({
    this.code,
    this.message,
    this.transaction,
    this.transactionItems,
    this.url,
  });

  int code;
  String message;
  Transactions transaction;
  List<TransactionItem> transactionItems;
  String url;

  DigitalPaymentResponseModel copyWith({
    int code,
    String message,
    Transactions transaction,
    List<TransactionItem> transactionItems,
    String url,
  }) =>
      DigitalPaymentResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        transaction: transaction ?? this.transaction,
        transactionItems: transactionItems ?? this.transactionItems,
        url: url ?? this.url,
      );

  factory DigitalPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      DigitalPaymentResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        transaction: json["transaction"] == null
            ? null
            : Transactions.fromJson(json["transaction"]),
        transactionItems: json["transaction_items"] == null
            ? null
            : List<TransactionItem>.from(json["transaction_items"]
                .map((x) => TransactionItem.fromJson(x))),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "transaction": transaction == null ? null : transaction.toJson(),
        "transaction_items": transactionItems == null
            ? null
            : List<dynamic>.from(transactionItems.map((x) => x.toJson())),
        "url": url == null ? null : url,
      };
}
