
// To parse this JSON data, do
//
//     final addDueItemRequest = addDueItemRequestFromJson(jsonString);

import 'dart:convert';

AddDueItemRequest addDueItemRequestFromJson(String str) => AddDueItemRequest.fromJson(json.decode(str));

String addDueItemRequestToJson(AddDueItemRequest data) => json.encode(data.toJson());

class AddDueItemRequest {
  AddDueItemRequest({
    this.amount,
    this.shopId,
    this.uniqueId,
    this.dueUniqueId,
    this.dueLeft,
    this.version,
    this.updatedAt,
    this.createdAt,
  });

  double amount;
  int shopId;
  String uniqueId;
  String dueUniqueId;
  int dueLeft;
  int version;
  String updatedAt;
  String createdAt;

  AddDueItemRequest copyWith({
    double amount,
    int shopId,
    String uniqueId,
    String dueUniqueId,
    int dueLeft,
    int version,
    String updatedAt,
    String createdAt,
  }) =>
      AddDueItemRequest(
        amount: amount ?? this.amount,
        shopId: shopId ?? this.shopId,
        uniqueId: uniqueId ?? this.uniqueId,
        dueUniqueId: dueUniqueId ?? this.dueUniqueId,
        dueLeft: dueLeft ?? this.dueLeft,
        version: version ?? this.version,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory AddDueItemRequest.fromJson(Map<String, dynamic> json) => AddDueItemRequest(
    amount: json["amount"],
    shopId: json["shop_id"],
    uniqueId: json["unique_id"],
    dueUniqueId: json["due_unique_id"],
    dueLeft: json["due_left"],
    version: json["version"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "shop_id": shopId,
    "unique_id": uniqueId,
    "due_unique_id": dueUniqueId,
    "due_left": dueLeft,
    "version": version,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}
