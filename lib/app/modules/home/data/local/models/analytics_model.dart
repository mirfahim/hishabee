// To parse this JSON data, do
//
//     final analyticsModel = analyticsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AnalyticsModel> analyticsModelFromJson(String str) =>
    List<AnalyticsModel>.from(
        json.decode(str).map((x) => AnalyticsModel.fromJson(x)));

String analyticsModelToJson(List<AnalyticsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnalyticsModel {
  AnalyticsModel({
    @required this.shopId,
    @required this.event,
    @required this.platform,
    this.type,
  });

  int shopId;
  String event;
  String platform;
  String type;

  AnalyticsModel copyWith({
    int shopId,
    String event,
    String platform,
    String type,
  }) =>
      AnalyticsModel(
        shopId: shopId ?? this.shopId,
        event: event ?? this.event,
        platform: platform ?? this.platform,
        type: type ?? this.type,
      );

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) => AnalyticsModel(
        shopId: json["shopId"] == null ? null : json["shopId"],
        event: json["event"] == null ? null : json["event"],
        platform: json["platform"] == null ? null : json["platform"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "shopId": shopId == null ? null : shopId,
        "event": event == null ? null : event,
        "platform": platform == null ? null : platform,
        "type": type == null ? null : type,
      };
}
