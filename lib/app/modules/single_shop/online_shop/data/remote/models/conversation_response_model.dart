// To parse this JSON data, do
//
//     final conversationResponseModel = conversationResponseModelFromJson(jsonString);

import 'dart:convert';

List<Conversation> conversationResponseModelFromJson(String str) =>
    List<Conversation>.from(
        json.decode(str).map((x) => Conversation.fromJson(x)));
List<Conversation> conversationResponseModelFromRawJson(dynamic json) =>
    List<Conversation>.from(
        (json as List<dynamic>).map((x) => Conversation.fromJson(x)));

String conversationResponseModelToJson(List<Conversation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Conversation {
  Conversation({
    this.id,
    this.shopId,
    this.senderId,
    this.senderUnread,
    this.receiverId,
    this.receiverUnread,
    this.createdAt,
    this.updatedAt,
    this.number,
    this.name,
    this.productId,
    this.title,
    this.lastMessage,
  });

  int id;
  int shopId;
  dynamic senderId;
  int senderUnread;
  int receiverId;
  int receiverUnread;
  DateTime createdAt;
  DateTime updatedAt;
  String number;
  String name;
  dynamic productId;
  dynamic title;
  LastMessage lastMessage;

  Conversation copyWith({
    int id,
    int shopId,
    dynamic senderId,
    int senderUnread,
    int receiverId,
    int receiverUnread,
    DateTime createdAt,
    DateTime updatedAt,
    String number,
    String name,
    dynamic productId,
    dynamic title,
    LastMessage lastMessage,
  }) =>
      Conversation(
        id: id ?? this.id,
        shopId: shopId ?? this.shopId,
        senderId: senderId ?? this.senderId,
        senderUnread: senderUnread ?? this.senderUnread,
        receiverId: receiverId ?? this.receiverId,
        receiverUnread: receiverUnread ?? this.receiverUnread,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        number: number ?? this.number,
        name: name ?? this.name,
        productId: productId ?? this.productId,
        title: title ?? this.title,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"] == null ? null : json["id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        senderId: json["sender_id"],
        senderUnread:
            json["sender_unread"] == null ? null : json["sender_unread"],
        receiverId: json["receiver_id"] == null ? null : json["receiver_id"],
        receiverUnread:
            json["receiver_unread"] == null ? null : json["receiver_unread"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        number: json["number"] == null ? null : json["number"],
        name: json["name"] == null ? null : json["name"],
        productId: json["product_id"],
        title: json["title"],
        lastMessage: json["last_message"] == null
            ? null
            : LastMessage.fromJson(json["last_message"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "shop_id": shopId == null ? null : shopId,
        "sender_id": senderId,
        "sender_unread": senderUnread == null ? null : senderUnread,
        "receiver_id": receiverId == null ? null : receiverId,
        "receiver_unread": receiverUnread == null ? null : receiverUnread,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "number": number == null ? null : number,
        "name": name == null ? null : name,
        "product_id": productId,
        "title": title,
        "last_message": lastMessage == null ? null : lastMessage.toJson(),
      };
}

class LastMessage {
  LastMessage({
    this.userId,
    this.conversationId,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int userId;
  int conversationId;
  String message;
  String updatedAt;
  String createdAt;
  int id;

  LastMessage copyWith({
    int userId,
    String conversationId,
    String message,
    String updatedAt,
    String createdAt,
    int id,
  }) =>
      LastMessage(
        userId: userId ?? this.userId,
        conversationId: conversationId ?? this.conversationId,
        message: message ?? this.message,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        userId: json["user_id"] == null ? null : json["user_id"],
        conversationId:
            json["conversation_id"] == null ? null : json["conversation_id"],
        message: json["message"] == null ? null : json["message"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "conversation_id": conversationId == null ? null : conversationId,
        "message": message == null ? null : message,
        "updated_at": updatedAt == null ? null : updatedAt,
        "created_at": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
      };
}
