// To parse this JSON data, do
//
//     final getAllMessage = getAllMessageFromJson(jsonString);

import 'dart:convert';

List<GetAllMessage> getSmsFromModel(dynamic str) =>
    List<GetAllMessage>.from(str.map((x) => GetAllMessage.fromJson(x)));

GetAllMessage getAllMessageModelFromJson(Map<String, dynamic> json) =>
    GetAllMessage.fromJson(json);

List<GetAllMessage> getAllMessageFromJson(String str) =>
    List<GetAllMessage>.from(
        json.decode(str).map((x) => GetAllMessage.fromJson(x)));

String getAllMessageToJson(List<GetAllMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllMessage {
  GetAllMessage({
    this.id,
    this.number,
    this.createdAt,
    this.updatedAt,
    this.message,
    this.shopId,
    this.messageCount,
  });

  int id;
  String number;
  DateTime createdAt;
  DateTime updatedAt;
  String message;
  int shopId;
  int messageCount;

  factory GetAllMessage.fromJson(Map<String, dynamic> json) => GetAllMessage(
        id: json["id"],
        number: json["number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        message: json["message"],
        shopId: json["shop_id"],
        messageCount: json["message_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "message": message,
        "shop_id": shopId,
        "message_count": messageCount,
      };
}
