// To parse this JSON data, do
//
//     final smsPackages = smsPackagesFromJson(jsonString);

import 'dart:convert';

List<SmsPackages> getSmsPackagesFromModel(dynamic str) =>
    List<SmsPackages>.from(str.map((x) => SmsPackages.fromJson(x)));

List<SmsPackages> smsPackagesFromJson(String str) => List<SmsPackages>.from(
    json.decode(str).map((x) => SmsPackages.fromJson(x)));

String smsPackagesToJson(List<SmsPackages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SmsPackages {
  SmsPackages({
    this.id,
    this.description,
    this.smsAmount,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String description;
  int smsAmount;
  int price;
  dynamic createdAt;
  dynamic updatedAt;

  factory SmsPackages.fromJson(Map<String, dynamic> json) => SmsPackages(
        id: json["id"],
        description: json["description"],
        smsAmount: json["sms_amount"],
        price: json["price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "sms_amount": smsAmount,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
