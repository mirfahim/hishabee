// To parse this JSON data, do
//
//     final addDueRequest = addDueRequestFromJson(jsonString);

import 'dart:convert';

AddDueRequest addDueRequestFromJson(String str) => AddDueRequest.fromJson(json.decode(str));

String addDueRequestToJson(AddDueRequest data) => json.encode(data.toJson());

class AddDueRequest {
  AddDueRequest({
    this.amount,
    this.shopId,
    this.uniqueId,
    this.contactType,
    this.contactMobile,
    this.contactName,
    this.version,
    this.updatedAt,
    this.createdAt,
  });

  double amount;
  int shopId;
  String uniqueId;
  String contactType;
  String contactMobile;
  String contactName;
  int version;
  String updatedAt;
  String createdAt;

  AddDueRequest copyWith({
    double amount,
    int shopId,
    String uniqueId,
    String contactType,
    String contactMobile,
    String contactName,
    int version,
    String updatedAt,
    String createdAt,
  }) =>
      AddDueRequest(
        amount: amount ?? this.amount,
        shopId: shopId ?? this.shopId,
        uniqueId: uniqueId ?? this.uniqueId,
        contactType: contactType ?? this.contactType,
        contactMobile: contactMobile ?? this.contactMobile,
        contactName: contactName ?? this.contactName,
        version: version ?? this.version,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory AddDueRequest.fromJson(Map<String, dynamic> json) => AddDueRequest(
    amount: json["amount"],
    shopId: json["shop_id"],
    uniqueId: json["unique_id"],
    contactType: json["contact_type"],
    contactMobile: json["contact_mobile"],
    contactName: json["contact_name"],
    version: json["version"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "shop_id": shopId,
    "unique_id": uniqueId,
    "contact_type": contactType,
    "contact_mobile": contactMobile,
    "contact_name": contactName,
    "version": version,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}
