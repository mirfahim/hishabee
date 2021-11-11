// To parse this JSON data, do
//
//     final walletResponse = walletResponseFromJson(jsonString);

import 'dart:convert';

WalletResponse walletResponseFromJson(String str) =>
    WalletResponse.fromJson(json.decode(str));
WalletResponse walletResponseFromRawJson(dynamic json) {
  print("Json : $json");
  return WalletResponse.fromJson(json);
}

String walletResponseToJson(WalletResponse data) => json.encode(data.toJson());

class WalletResponse {
  WalletResponse({
    this.code,
    this.message,
    this.wallet,
  });

  int code;
  String message;
  Wallet wallet;

  WalletResponse copyWith({
    int code,
    String message,
    Wallet wallet,
  }) =>
      WalletResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        wallet: wallet ?? this.wallet,
      );

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "wallet": wallet == null ? null : wallet.toJson(),
      };
}

class Wallet {
  Wallet({
    this.id,
    this.userId,
    this.shopId,
    this.totalBalance,
    this.liquidBalance,
    this.hishabeeGrant,
    this.giftPoints,
    this.walletBarcode,
    this.createdAt,
    this.updatedAt,
    this.hishabeeCredit,
    this.walletTransaction,
  });

  int id;
  int userId;
  int shopId;
  int totalBalance;
  int liquidBalance;
  int hishabeeGrant;
  int giftPoints;
  dynamic walletBarcode;
  DateTime createdAt;
  DateTime updatedAt;
  int hishabeeCredit;
  List<WalletTransaction> walletTransaction;

  Wallet copyWith({
    int id,
    int userId,
    int shopId,
    int totalBalance,
    int liquidBalance,
    int hishabeeGrant,
    int giftPoints,
    dynamic walletBarcode,
    DateTime createdAt,
    DateTime updatedAt,
    int hishabeeCredit,
    List<WalletTransaction> walletTransaction,
  }) =>
      Wallet(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        totalBalance: totalBalance ?? this.totalBalance,
        liquidBalance: liquidBalance ?? this.liquidBalance,
        hishabeeGrant: hishabeeGrant ?? this.hishabeeGrant,
        giftPoints: giftPoints ?? this.giftPoints,
        walletBarcode: walletBarcode ?? this.walletBarcode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        hishabeeCredit: hishabeeCredit ?? this.hishabeeCredit,
        walletTransaction: walletTransaction ?? this.walletTransaction,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        totalBalance:
            json["total_balance"] == null ? null : json["total_balance"],
        liquidBalance:
            json["liquid_balance"] == null ? null : json["liquid_balance"],
        hishabeeGrant:
            json["hishabee_grant"] == null ? null : json["hishabee_grant"],
        giftPoints: json["gift_points"] == null ? null : json["gift_points"],
        walletBarcode: json["wallet_barcode"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        hishabeeCredit:
            json["hishabee_credit"] == null ? null : json["hishabee_credit"],
        walletTransaction: json["wallet_transaction"] == null
            ? null
            : List<WalletTransaction>.from(json["wallet_transaction"]
                .map((x) => WalletTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "total_balance": totalBalance == null ? null : totalBalance,
        "liquid_balance": liquidBalance == null ? null : liquidBalance,
        "hishabee_grant": hishabeeGrant == null ? null : hishabeeGrant,
        "gift_points": giftPoints == null ? null : giftPoints,
        "wallet_barcode": walletBarcode,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "hishabee_credit": hishabeeCredit == null ? null : hishabeeCredit,
        "wallet_transaction": walletTransaction == null
            ? null
            : List<dynamic>.from(walletTransaction.map((x) => x.toJson())),
      };
}

class WalletTransaction {
  WalletTransaction({
    this.id,
    this.walletId,
    this.amount,
    this.type,
    this.note,
    this.transactionId,
    this.referenceId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int walletId;
  int amount;
  String type;
  String note;
  dynamic transactionId;
  dynamic referenceId;
  DateTime createdAt;
  DateTime updatedAt;

  WalletTransaction copyWith({
    int id,
    int walletId,
    int amount,
    String type,
    String note,
    dynamic transactionId,
    dynamic referenceId,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      WalletTransaction(
        id: id ?? this.id,
        walletId: walletId ?? this.walletId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        note: note ?? this.note,
        transactionId: transactionId ?? this.transactionId,
        referenceId: referenceId ?? this.referenceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      WalletTransaction(
        id: json["id"] == null ? null : json["id"],
        walletId: json["wallet_id"] == null ? null : json["wallet_id"],
        amount: json["amount"] == null ? null : json["amount"],
        type: json["type"] == null ? null : json["type"],
        note: json["note"] == null ? null : json["note"],
        transactionId: json["transaction_id"],
        referenceId: json["reference_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "wallet_id": walletId == null ? null : walletId,
        "amount": amount == null ? null : amount,
        "type": type == null ? null : type,
        "note": note == null ? null : note,
        "transaction_id": transactionId,
        "reference_id": referenceId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
