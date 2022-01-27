// To parse this JSON data, do
//
//     final addTransactionRequest = addTransactionRequestFromJson(jsonString);

import 'dart:convert';

AddTransactionRequest addTransactionRequestFromJson(String str) => AddTransactionRequest.fromJson(json.decode(str));

String addTransactionRequestToJson(AddTransactionRequest data) => json.encode(data.toJson());

class AddTransactionRequest {
  AddTransactionRequest({
    this.shopId,
    this.createdAt,
    this.updatedAt,
    this.totalPrice,
    this.totalDiscount,
    this.totalItem,
    this.paymentMethod,
    this.receivedAmount,
    this.changeAmount,
    this.employeeName,
    this.employeeMobile,
    this.customerName,
    this.customerAddress,
    this.customerMobile,
    this.transactionBarcode,
    this.totalVat,
    this.note,
    this.uniqueId,
    this.version,
    this.totalProfit,
    this.message,
    this.smsCount,
    this.transaction_type,
  });

  int shopId;
  String createdAt;
  String updatedAt;
  String totalPrice;
  int totalDiscount;
  int totalItem;
  int paymentMethod;
  String receivedAmount;
  String changeAmount;
  String employeeName;
  int employeeMobile;
  String customerName;
  String customerAddress;
  String customerMobile;
  String transactionBarcode;
  int totalVat;
  String note;
  String uniqueId;
  int version;
  String totalProfit;
  String message;
  int smsCount;
  String transaction_type;

  AddTransactionRequest copyWith({
    int shopId,
    String createdAt,
    String updatedAt,
    String totalPrice,
    int totalDiscount,
    int totalItem,
    int paymentMethod,
    String receivedAmount,
    String changeAmount,
    String employeeName,
    int employeeMobile,
    String customerName,
    String customerAddress,
    String customerMobile,
    String transactionBarcode,
    int totalVat,
    String note,
    String uniqueId,
    int version,
    String totalProfit,
    String message,
    int smsCount,
    String transaction_type
  }) =>
      AddTransactionRequest(
        shopId: shopId ?? this.shopId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalPrice: totalPrice ?? this.totalPrice,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalItem: totalItem ?? this.totalItem,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        receivedAmount: receivedAmount ?? this.receivedAmount,
        changeAmount: changeAmount ?? this.changeAmount,
        employeeName: employeeName ?? this.employeeName,
        employeeMobile: employeeMobile ?? this.employeeMobile,
        customerName: customerName ?? this.customerName,
        customerAddress: customerAddress ?? this.customerAddress,
        customerMobile: customerMobile ?? this.customerMobile,
        transactionBarcode: transactionBarcode ?? this.transactionBarcode,
        totalVat: totalVat ?? this.totalVat,
        note: note ?? this.note,
        uniqueId: uniqueId ?? this.uniqueId,
        version: version ?? this.version,
        totalProfit: totalProfit ?? this.totalProfit,
        message: message ?? this.message,
        smsCount: smsCount ?? this.smsCount,
        transaction_type: transaction_type??this.transaction_type,
      );

  factory AddTransactionRequest.fromJson(Map<String, dynamic> json) => AddTransactionRequest(
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    totalPrice: json["total_price"] == null ? null : json["total_price"],
    totalDiscount: json["total_discount"] == null ? null : json["total_discount"],
    totalItem: json["total_item"] == null ? null : json["total_item"],
    paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    receivedAmount: json["received_amount"] == null ? null : json["received_amount"],
    changeAmount: json["change_amount"] == null ? null : json["change_amount"],
    employeeName: json["employee_name"] == null ? null : json["employee_name"],
    employeeMobile: json["employee_mobile"] == null ? null : json["employee_mobile"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    customerAddress: json["customer_address"] == null ? null : json["customer_address"],
    customerMobile: json["customer_mobile"] == null ? null : json["customer_mobile"],
    transactionBarcode: json["transaction_barcode"] == null ? null : json["transaction_barcode"],
    totalVat: json["total_vat"] == null ? null : json["total_vat"],
    note: json["note"] == null ? null : json["note"],
    uniqueId: json["unique_id"] == null ? null : json["unique_id"],
    version: json["version"] == null ? null : json["version"],
    totalProfit: json["total_profit"] == null ? null : json["total_profit"],
    message: json["message"] == null ? null : json["message"],
    smsCount: json["sms_count"] == null ? null : json["sms_count"],
    transaction_type:json["transaction_type"] == null ? null : json["transaction_type"],
  );

  Map<String, dynamic> toJson() => {
    "shop_id": shopId == null ? null : shopId,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "total_price": totalPrice == null ? null : totalPrice,
    "total_discount": totalDiscount == null ? null : totalDiscount,
    "total_item": totalItem == null ? null : totalItem,
    "payment_method": paymentMethod == null ? null : paymentMethod,
    "received_amount": receivedAmount == null ? null : receivedAmount,
    "change_amount": changeAmount == null ? null : changeAmount,
    "employee_name": employeeName == null ? null : employeeName,
    "employee_mobile": employeeMobile == null ? null : employeeMobile,
    "customer_name": customerName == null ? null : customerName,
    "customer_address": customerAddress == null ? null : customerAddress,
    "customer_mobile": customerMobile == null ? null : customerMobile,
    "transaction_barcode": transactionBarcode == null ? null : transactionBarcode,
    "total_vat": totalVat == null ? null : totalVat,
    "note": note == null ? null : note,
    "unique_id": uniqueId == null ? null : uniqueId,
    "version": version == null ? null : version,
    "total_profit": totalProfit == null ? null : totalProfit,
    "message": message == null ? null : message,
    "sms_count": smsCount == null ? null : smsCount,
    "transaction_type": transaction_type==null?null:transaction_type
  };
}
