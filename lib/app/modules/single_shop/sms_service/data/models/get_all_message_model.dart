// To parse this JSON data, do
//
//     final getAllMessage = getAllMessageFromJson(jsonString);

import 'dart:convert';

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
  DateTime message;
  int shopId;
  int messageCount;

  factory GetAllMessage.fromJson(Map<String, dynamic> json) => GetAllMessage(
        id: json["id"],
        number: json["number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        message: DateTime.parse(json["message"]),
        shopId: json["shop_id"],
        messageCount: json["message_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "message":
            "${message.year.toString().padLeft(4, '0')}-${message.month.toString().padLeft(2, '0')}-${message.day.toString().padLeft(2, '0')}",
        "shop_id": shopId,
        "message_count": messageCount,
      };
}
