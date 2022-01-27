// To parse this JSON data, do
//
//     final quickSellResponse = quickSellResponseFromJson(jsonString);

import 'dart:convert';

QuickSellResponse quickSellResponseFromJson(String str) => QuickSellResponse.fromJson(json.decode(str));
QuickSellResponse quickSellResponseFromRawJson(dynamic json) => QuickSellResponse.fromJson(json);

String quickSellResponseToJson(QuickSellResponse data) => json.encode(data.toJson());

class QuickSellResponse {
  QuickSellResponse({
    this.code,
    this.message,
    this.quickSell,
  });

  int code;
  String message;
  QuickSell quickSell;

  QuickSellResponse copyWith({
    int code,
    String message,
    QuickSell quickSell,
  }) =>
      QuickSellResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        quickSell: quickSell ?? this.quickSell,
      );

  factory QuickSellResponse.fromJson(Map<String, dynamic> json) => QuickSellResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    quickSell: json["quick_sell"] == null ? null : QuickSell.fromJson(json["quick_sell"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "quick_sell": quickSell == null ? null : quickSell.toJson(),
  };
}

class QuickSell {
  QuickSell({
    this.id,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.details,
    this.image,
    this.transactionUniqueId,
    this.uniqueId,
    this.version,
    this.shopId,
    this.transactionId,
  });

  int id;
  String price;
  String createdAt;
  String updatedAt;
  String details;
  dynamic image;
  String transactionUniqueId;
  String uniqueId;
  int version;
  String shopId;
  dynamic transactionId;

  QuickSell copyWith({
    int id,
    String price,
    String createdAt,
    String updatedAt,
    String details,
    dynamic image,
    String transactionUniqueId,
    String uniqueId,
    int version,
    String shopId,
    dynamic transactionId,
  }) =>
      QuickSell(
        id: id ?? this.id,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        details: details ?? this.details,
        image: image ?? this.image,
        transactionUniqueId: transactionUniqueId ?? this.transactionUniqueId,
        uniqueId: uniqueId ?? this.uniqueId,
        version: version ?? this.version,
        shopId: shopId ?? this.shopId,
        transactionId: transactionId ?? this.transactionId,
      );

  factory QuickSell.fromJson(Map<String, dynamic> json) => QuickSell(
    id: json["id"] == null ? null : json["id"],
    price: json["price"] == null ? null : json["price"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    details: json["details"] == null ? null : json["details"],
    image: json["image"],
    transactionUniqueId: json["transaction_unique_id"] == null ? null : json["transaction_unique_id"],
    uniqueId: json["unique_id"] == null ? null : json["unique_id"],
    version: json["version"] == null ? null : json["version"],
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "price": price == null ? null : price,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "details": details == null ? null : details,
    "image": image,
    "transaction_unique_id": transactionUniqueId == null ? null : transactionUniqueId,
    "unique_id": uniqueId == null ? null : uniqueId,
    "version": version == null ? null : version,
    "shop_id": shopId == null ? null : shopId,
    "transaction_id": transactionId,
  };
}
