// To parse this JSON data, do
//
//     final accountInformationResponseModel = accountInformationResponseModelFromJson(jsonString);

import 'dart:convert';

AccountInformationResponseModel accountInformationResponseModelFromJson(
        String str) =>
    AccountInformationResponseModel.fromJson(json.decode(str));
AccountInformationResponseModel accountInformationResponseModelFromRawJson(
        dynamic json) =>
    AccountInformationResponseModel.fromJson(json);

String accountInformationResponseModelToJson(
        AccountInformationResponseModel data) =>
    json.encode(data.toJson());

class AccountInformationResponseModel {
  AccountInformationResponseModel({
    this.code,
    this.message,
    this.seller,
  });

  int code;
  String message;
  Seller seller;

  AccountInformationResponseModel copyWith({
    int code,
    String message,
    Seller seller,
  }) =>
      AccountInformationResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        seller: seller ?? this.seller,
      );

  factory AccountInformationResponseModel.fromJson(Map<String, dynamic> json) =>
      AccountInformationResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "seller": seller == null ? null : seller.toJson(),
      };
}

class Seller {
  Seller({
    this.id,
    this.userId,
    this.verificationStatus,
    this.verificationInfo,
    this.cashOnDeliveryStatus,
    this.adminToPay,
    this.bankName,
    this.bankAccName,
    this.bankAccNo,
    this.bankRoutingNo,
    this.bankPaymentStatus,
    this.digitalPayout,
    this.nagad,
    this.rocket,
    this.bkash,
    this.createdAt,
    this.updatedAt,
    this.accountType,
  });

  int id;
  int userId;
  int verificationStatus;
  dynamic verificationInfo;
  int cashOnDeliveryStatus;
  int adminToPay;
  String bankName;
  String bankAccName;
  String bankAccNo;
  int bankRoutingNo;
  int bankPaymentStatus;
  int digitalPayout;
  dynamic nagad;
  dynamic rocket;
  String bkash;
  DateTime createdAt;
  DateTime updatedAt;
  String accountType;

  Seller copyWith({
    int id,
    int userId,
    int verificationStatus,
    dynamic verificationInfo,
    int cashOnDeliveryStatus,
    int adminToPay,
    String bankName,
    String bankAccName,
    String bankAccNo,
    int bankRoutingNo,
    int bankPaymentStatus,
    int digitalPayout,
    dynamic nagad,
    dynamic rocket,
    String bkash,
    DateTime createdAt,
    DateTime updatedAt,
    String accountType,
  }) =>
      Seller(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        verificationInfo: verificationInfo ?? this.verificationInfo,
        cashOnDeliveryStatus: cashOnDeliveryStatus ?? this.cashOnDeliveryStatus,
        adminToPay: adminToPay ?? this.adminToPay,
        bankName: bankName ?? this.bankName,
        bankAccName: bankAccName ?? this.bankAccName,
        bankAccNo: bankAccNo ?? this.bankAccNo,
        bankRoutingNo: bankRoutingNo ?? this.bankRoutingNo,
        bankPaymentStatus: bankPaymentStatus ?? this.bankPaymentStatus,
        digitalPayout: digitalPayout ?? this.digitalPayout,
        nagad: nagad ?? this.nagad,
        rocket: rocket ?? this.rocket,
        bkash: bkash ?? this.bkash,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        accountType: accountType ?? this.accountType,
      );

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        verificationStatus: json["verification_status"] == null
            ? null
            : json["verification_status"],
        verificationInfo: json["verification_info"],
        cashOnDeliveryStatus: json["cash_on_delivery_status"] == null
            ? null
            : json["cash_on_delivery_status"],
        adminToPay: json["admin_to_pay"] == null ? null : json["admin_to_pay"],
        bankName: json["bank_name"] == null ? null : json["bank_name"],
        bankAccName:
            json["bank_acc_name"] == null ? null : json["bank_acc_name"],
        bankAccNo: json["bank_acc_no"] == null ? null : json["bank_acc_no"],
        bankRoutingNo:
            json["bank_routing_no"] == null ? null : json["bank_routing_no"],
        bankPaymentStatus: json["bank_payment_status"] == null
            ? null
            : json["bank_payment_status"],
        digitalPayout:
            json["digital_payout"] == null ? null : json["digital_payout"],
        nagad: json["nagad"],
        rocket: json["rocket"],
        bkash: json["bkash"] == null ? null : json["bkash"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        accountType: json["account_type"] == null ? null : json["account_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "verification_status":
            verificationStatus == null ? null : verificationStatus,
        "verification_info": verificationInfo,
        "cash_on_delivery_status":
            cashOnDeliveryStatus == null ? null : cashOnDeliveryStatus,
        "admin_to_pay": adminToPay == null ? null : adminToPay,
        "bank_name": bankName == null ? null : bankName,
        "bank_acc_name": bankAccName == null ? null : bankAccName,
        "bank_acc_no": bankAccNo == null ? null : bankAccNo,
        "bank_routing_no": bankRoutingNo == null ? null : bankRoutingNo,
        "bank_payment_status":
            bankPaymentStatus == null ? null : bankPaymentStatus,
        "digital_payout": digitalPayout == null ? null : digitalPayout,
        "nagad": nagad,
        "rocket": rocket,
        "bkash": bkash == null ? null : bkash,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "account_type": accountType == null ? null : accountType,
      };
}
