// To parse this JSON data, do
//
//     final addTransactionResponse = addTransactionResponseFromJson(jsonString);

import 'dart:convert';

AddTransactionResponse addTransactionResponseFromJson(String str) => AddTransactionResponse.fromJson(json.decode(str));
AddTransactionResponse addTransactionResponseFromRawJson(dynamic json) => AddTransactionResponse.fromJson(json);

String addTransactionResponseToJson(AddTransactionResponse data) => json.encode(data.toJson());

class AddTransactionResponse {
  AddTransactionResponse({
    this.code,
    this.message,
    this.transaction,
  });

  int code;
  String message;
  Transaction transaction;

  AddTransactionResponse copyWith({
    int code,
    String message,
    Transaction transaction,
  }) =>
      AddTransactionResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        transaction: transaction ?? this.transaction,
      );

  factory AddTransactionResponse.fromJson(Map<String, dynamic> json) => AddTransactionResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    transaction: json["transaction"] == null ? null : Transaction.fromJson(json["transaction"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "transaction": transaction == null ? null : transaction.toJson(),
  };
}

class Transaction {
  Transaction({
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
    this.totalProfit,
    this.trxId,
    this.transactionType,
    this.uniqueId,
    this.version,
    this.time,
  });

  int id;
  int userId;
  String shopId;
  String totalPrice;
  String totalDiscount;
  String totalItem;
  int paymentMethod;
  String receivedAmount;
  String changeAmount;
  dynamic employeeName;
  String customerName;
  String customerAddress;
  String customerMobile;
  String transactionBarcode;
  String createdAt;
  String updatedAt;
  String totalVat;
  String note;
  String paymentStatus;
  dynamic localId;
  dynamic employeeMobile;
  String totalProfit;
  dynamic trxId;
  String transactionType;
  String uniqueId;
  int version;
  String time;

  Transaction copyWith({
    int id,
    int userId,
    String shopId,
    String totalPrice,
    String totalDiscount,
    String totalItem,
    int paymentMethod,
    String receivedAmount,
    String changeAmount,
    dynamic employeeName,
    String customerName,
    String customerAddress,
    String customerMobile,
    String transactionBarcode,
    String createdAt,
    String updatedAt,
    String totalVat,
    String note,
    String paymentStatus,
    dynamic localId,
    dynamic employeeMobile,
    String totalProfit,
    dynamic trxId,
    String transactionType,
    String uniqueId,
    int version,
    String time,
  }) =>
      Transaction(
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
        totalProfit: totalProfit ?? this.totalProfit,
        trxId: trxId ?? this.trxId,
        transactionType: transactionType ?? this.transactionType,
        uniqueId: uniqueId ?? this.uniqueId,
        version: version ?? this.version,
        time: time ?? this.time,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    totalPrice: json["total_price"] == null ? null : json["total_price"],
    totalDiscount: json["total_discount"] == null ? null : json["total_discount"],
    totalItem: json["total_item"] == null ? null : json["total_item"],
    paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    receivedAmount: json["received_amount"] == null ? null : json["received_amount"],
    changeAmount: json["change_amount"] == null ? null : json["change_amount"],
    employeeName: json["employee_name"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    customerAddress: json["customer_address"] == null ? null : json["customer_address"],
    customerMobile: json["customer_mobile"] == null ? null : json["customer_mobile"],
    transactionBarcode: json["transaction_barcode"] == null ? null : json["transaction_barcode"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    totalVat: json["total_vat"] == null ? null : json["total_vat"],
    note: json["note"] == null ? null : json["note"],
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    localId: json["local_id"],
    employeeMobile: json["employee_mobile"],
    totalProfit: json["total_profit"] == null ? null : json["total_profit"],
    trxId: json["trx_id"],
    transactionType: json["transaction_type"] == null ? null : json["transaction_type"],
    uniqueId: json["unique_id"] == null ? null : json["unique_id"],
    version: json["version"] == null ? null : json["version"],
    time: json["time"] == null ? null : json["time"],
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
    "employee_name": employeeName,
    "customer_name": customerName == null ? null : customerName,
    "customer_address": customerAddress == null ? null : customerAddress,
    "customer_mobile": customerMobile == null ? null : customerMobile,
    "transaction_barcode": transactionBarcode == null ? null : transactionBarcode,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "total_vat": totalVat == null ? null : totalVat,
    "note": note == null ? null : note,
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "local_id": localId,
    "employee_mobile": employeeMobile,
    "total_profit": totalProfit == null ? null : totalProfit,
    "trx_id": trxId,
    "transaction_type": transactionType == null ? null : transactionType,
    "unique_id": uniqueId == null ? null : uniqueId,
    "version": version == null ? null : version,
    "time": time == null ? null : time,
  };
}
