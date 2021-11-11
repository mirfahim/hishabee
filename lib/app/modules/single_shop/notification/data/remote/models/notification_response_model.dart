// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

List<NotificationResponseModel> notificationResponseModelFromJson(String str) =>
    List<NotificationResponseModel>.from(
        json.decode(str).map((x) => NotificationResponseModel.fromJson(x)));

List<NotificationResponseModel> notificationResponseModelFromRawJson(
    dynamic json) {
  return List<NotificationResponseModel>.from((json as List<dynamic>)
      .map((x) => NotificationResponseModel.fromJson(x)));
}

String notificationResponseModelToJson(List<NotificationResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationResponseModel {
  NotificationResponseModel({
    this.userId,
    this.shopId,
    this.title,
    this.details,
    this.action,
    this.event,
    this.remoteId,
    this.time,
  });

  int userId;
  int shopId;
  String title;
  String details;
  String action;
  String event;
  String remoteId;
  DateTime time;

  NotificationResponseModel copyWith({
    int userId,
    int shopId,
    String title,
    String details,
    String action,
    String event,
    String remoteId,
    DateTime time,
  }) =>
      NotificationResponseModel(
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        title: title ?? this.title,
        details: details ?? this.details,
        action: action ?? this.action,
        event: event ?? this.event,
        remoteId: remoteId ?? this.remoteId,
        time: time ?? this.time,
      );

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        title: json["title"] == null ? null : json["title"],
        details: json["details"] == null ? null : json["details"],
        action: json["action"] == null ? null : json["action"],
        event: json["event"] == null ? null : json["event"],
        remoteId: json["remote_id"] == null ? null : json["remote_id"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "title": title == null ? null : title,
        "details": details == null ? null : details,
        "action": action == null ? null : action,
        "event": event == null ? null : event,
        "remote_id": remoteId == null ? null : remoteId,
        "time": time == null ? null : time.toIso8601String(),
      };
}
