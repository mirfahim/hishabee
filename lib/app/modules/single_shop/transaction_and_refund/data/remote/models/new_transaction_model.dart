// To parse this JSON data, do
//
//     final transactionResponseModel = transactionResponseModelFromJson(jsonString);

import 'dart:convert';

import 'transaction_item_response_model.dart';

List<Transactionsss> transactionResponseModelFromJson(String str) =>
    List<Transactionsss>.from(
        json.decode(str).map((x) => Transactionsss.fromJson(x)));
List<Transactionsss> transactionResponseModelFromRawJson(dynamic json) =>
    List<Transactionsss>.from(
        (json as List<dynamic>).map((x) => Transactionsss.fromJson(x)));

String transactionResponseModelToJson(List<Transactionsss> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transactionsss {
  Transactionsss({
    this.id,
    this.userId,
    this.shopId,
    this.totalPrice,
    this.totalDiscount,
    this.totalItem,
    this.paymentMethod,
    this.receivedAmount,
    this.changeAmount,
    this.employeeName,
    this.customerName,
    this.customerAddress,
    this.customerMobile,
    this.transactionBarcode,
    this.createdAt,
    this.updatedAt,
    this.totalVat,
    this.note,
    this.paymentStatus,
    this.localId,
    this.employeeMobile,
    this.time,
    this.transactionItems,
  });

  int id;
  int userId;
  int shopId;
  double totalPrice;
  num totalDiscount;
  int totalItem;
  int paymentMethod;
  double receivedAmount;
  int changeAmount;
  String employeeName;
  String customerName;
  String customerAddress;
  String customerMobile;
  String transactionBarcode;
  DateTime createdAt;
  DateTime updatedAt;
  num totalVat;
  String note;
  String paymentStatus;
  int localId;
  String employeeMobile;
  DateTime time;
  List<TransactionItem> transactionItems;

  Transactionsss copyWith({
    int id,
    int userId,
    int shopId,
    double totalPrice,
    int totalDiscount,
    int totalItem,
    int paymentMethod,
    double receivedAmount,
    int changeAmount,
    String employeeName,
    String customerName,
    String customerAddress,
    String customerMobile,
    String transactionBarcode,
    DateTime createdAt,
    DateTime updatedAt,
    double totalVat,
    String note,
    String paymentStatus,
    int localId,
    String employeeMobile,
    DateTime time,
    List<TransactionItem> transactionItems,
  }) =>
      Transactionsss(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        totalPrice: totalPrice ?? this.totalPrice,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalItem: totalItem ?? this.totalItem,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        receivedAmount: receivedAmount ?? this.receivedAmount,
        changeAmount: changeAmount ?? this.changeAmount,
        employeeName: employeeName ?? this.employeeName,
        customerName: customerName ?? this.customerName,
        customerAddress: customerAddress ?? this.customerAddress,
        customerMobile: customerMobile ?? this.customerMobile,
        transactionBarcode: transactionBarcode ?? this.transactionBarcode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalVat: totalVat ?? this.totalVat,
        note: note ?? this.note,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        localId: localId ?? this.localId,
        employeeMobile: employeeMobile ?? this.employeeMobile,
        time: time ?? this.time,
        transactionItems: transactionItems ?? this.transactionItems,
      );

  factory Transactionsss.fromJson(Map<String, dynamic> json) => Transactionsss(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        totalDiscount:
            json["total_discount"] == null ? null : json["total_discount"],
        totalItem: json["total_item"] == null ? null : json["total_item"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        receivedAmount: json["received_amount"] == null
            ? null
            : json["received_amount"].toDouble(),
        changeAmount:
            json["change_amount"] == null ? null : json["change_amount"],
        employeeName:
            json["employee_name"] == null ? null : json["employee_name"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        customerAddress:
            json["customer_address"] == null ? null : json["customer_address"],
        customerMobile:
            json["customer_mobile"] == null ? null : json["customer_mobile"],
        transactionBarcode: json["transaction_barcode"] == null
            ? null
            : json["transaction_barcode"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalVat:
            json["total_vat"] == null ? null : json["total_vat"].toDouble(),
        note: json["note"] == null ? null : json["note"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        localId: json["local_id"] == null ? null : json["local_id"],
        employeeMobile:
            json["employee_mobile"] == null ? null : json["employee_mobile"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        transactionItems: json["transaction_items"] == null
            ? null
            : List<TransactionItem>.from(json["transaction_items"]
                .map((x) => TransactionItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "total_price": totalPrice == null ? null : totalPrice,
        "total_discount": totalDiscount == null ? null : totalDiscount,
        "total_item": totalItem == null ? null : totalItem,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "received_amount": receivedAmount == null ? null : receivedAmount,
        "change_amount": changeAmount == null ? null : changeAmount,
        "employee_name": employeeName == null ? null : employeeName,
        "customer_name": customerName == null ? null : customerName,
        "customer_address": customerAddress == null ? null : customerAddress,
        "customer_mobile": customerMobile == null ? null : customerMobile,
        "transaction_barcode":
            transactionBarcode == null ? null : transactionBarcode,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "total_vat": totalVat == null ? null : totalVat,
        "note": note == null ? null : note,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "local_id": localId == null ? null : localId,
        "employee_mobile": employeeMobile == null ? null : employeeMobile,
        "time": time == null ? null : time.toIso8601String(),
        "transaction_items": transactionItems == null
            ? null
            : List<dynamic>.from(transactionItems.map((x) => x.toJson())),
      };
}
