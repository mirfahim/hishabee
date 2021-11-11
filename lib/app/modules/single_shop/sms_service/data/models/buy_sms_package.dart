// To parse this JSON data, do
//
//     final buySmsPackage = buySmsPackageFromJson(jsonString);

import 'dart:convert';

BuySmsPackage buySmsPackageFromJson(String str) =>
    BuySmsPackage.fromJson(json.decode(str));

String buySmsPackageToJson(BuySmsPackage data) => json.encode(data.toJson());

class BuySmsPackage {
  BuySmsPackage({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory BuySmsPackage.fromJson(Map<String, dynamic> json) => BuySmsPackage(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
