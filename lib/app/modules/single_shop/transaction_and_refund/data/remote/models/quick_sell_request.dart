// To parse this JSON data, do
//
//     final quickSellRequest = quickSellRequestFromJson(jsonString);

import 'dart:convert';

QuickSellRequest quickSellRequestFromJson(String str) => QuickSellRequest.fromJson(json.decode(str));

String quickSellRequestToJson(QuickSellRequest data) => json.encode(data.toJson());

class QuickSellRequest {
  QuickSellRequest({
    this.shopId,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.details,
    this.image,
    this.uniqueId,
    this.version,
    this.transactionUniqueId,
    this.profit,
  });

  int shopId;
  String createdAt;
  String updatedAt;
  int price;
  String details;
  String image;
  String uniqueId;
  int version;
  String transactionUniqueId;
  int profit;

  QuickSellRequest copyWith({
    int shopId,
    String createdAt,
    String updatedAt,
    int price,
    String details,
    String image,
    String uniqueId,
    int version,
    String transactionUniqueId,
    int profit,
  }) =>
      QuickSellRequest(
        shopId: shopId ?? this.shopId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        price: price ?? this.price,
        details: details ?? this.details,
        image: image ?? this.image,
        uniqueId: uniqueId ?? this.uniqueId,
        version: version ?? this.version,
        transactionUniqueId: transactionUniqueId ?? this.transactionUniqueId,
        profit: profit??this.profit,
      );

  factory QuickSellRequest.fromJson(Map<String, dynamic> json) => QuickSellRequest(
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    price: json["price"] == null ? null : json["price"],
    details: json["details"] == null ? null : json["details"],
    image: json["image"] == null ? null : json["image"],
    uniqueId: json["unique_id"] == null ? null : json["unique_id"],
    version: json["version"] == null ? null : json["version"],
    profit: json["profit"] == null ? null : json["profit"],
    transactionUniqueId: json["transaction_unique_id"] == null ? null : json["transaction_unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "shop_id": shopId == null ? null : shopId,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "price": price == null ? null : price,
    "details": details == null ? null : details,
    "image": image == null ? null : image,
    "unique_id": uniqueId == null ? null : uniqueId,
    "version": version == null ? null : version,
    "transaction_unique_id": transactionUniqueId == null ? null : transactionUniqueId,
    "profit": profit == null ? null : profit,
  };
}
