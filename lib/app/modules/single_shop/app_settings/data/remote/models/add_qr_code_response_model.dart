// To parse this JSON data, do
//
//     final addQrCodeResponseModel = addQrCodeResponseModelFromJson(jsonString);

import 'dart:convert';

AddQrCodeResponseModel addQrCodeResponseModelFromJson(String str) =>
    AddQrCodeResponseModel.fromJson(json.decode(str));
AddQrCodeResponseModel addQrCodeResponseModelFromRawJson(dynamic json) =>
    AddQrCodeResponseModel.fromJson(json);

String addQrCodeResponseModelToJson(AddQrCodeResponseModel data) =>
    json.encode(data.toJson());

class AddQrCodeResponseModel {
  AddQrCodeResponseModel({
    this.code,
    this.message,
    this.qrcode,
  });

  int code;
  String message;
  Qrcode qrcode;

  AddQrCodeResponseModel copyWith({
    int code,
    String message,
    Qrcode qrcode,
  }) =>
      AddQrCodeResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        qrcode: qrcode ?? this.qrcode,
      );

  factory AddQrCodeResponseModel.fromJson(Map<String, dynamic> json) =>
      AddQrCodeResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        qrcode: json["qrcode"] == null ? null : Qrcode.fromJson(json["qrcode"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "qrcode": qrcode == null ? null : qrcode.toJson(),
      };
}

class Qrcode {
  Qrcode({
    this.id,
    this.userId,
    this.shopId,
    this.type,
    this.imageSrc,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int shopId;
  String type;
  String imageSrc;
  DateTime createdAt;
  DateTime updatedAt;

  Qrcode copyWith({
    int id,
    int userId,
    int shopId,
    String type,
    String imageSrc,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Qrcode(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        type: type ?? this.type,
        imageSrc: imageSrc ?? this.imageSrc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Qrcode.fromJson(Map<String, dynamic> json) => Qrcode(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        type: json["type"] == null ? null : json["type"],
        imageSrc: json["image_src"] == null ? null : json["image_src"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "type": type == null ? null : type,
        "image_src": imageSrc == null ? null : imageSrc,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
