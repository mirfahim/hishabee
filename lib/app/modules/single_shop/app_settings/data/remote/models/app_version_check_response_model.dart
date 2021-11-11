// To parse this JSON data, do
//
//     final appVersionCheckResponseModel = appVersionCheckResponseModelFromJson(jsonString);

import 'dart:convert';

AppVersionCheckResponseModel appVersionCheckResponseModelFromJson(String str) =>
    AppVersionCheckResponseModel.fromJson(json.decode(str));
AppVersionCheckResponseModel appVersionCheckResponseModelFromRawJson(
        dynamic json) =>
    AppVersionCheckResponseModel.fromJson(json);

String appVersionCheckResponseModelToJson(AppVersionCheckResponseModel data) =>
    json.encode(data.toJson());

class AppVersionCheckResponseModel {
  AppVersionCheckResponseModel({
    this.code,
    this.message,
    this.version,
  });

  int code;
  String message;
  Version version;

  AppVersionCheckResponseModel copyWith({
    int code,
    String message,
    Version version,
  }) =>
      AppVersionCheckResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        version: version ?? this.version,
      );

  factory AppVersionCheckResponseModel.fromJson(Map<String, dynamic> json) =>
      AppVersionCheckResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        version:
            json["version"] == null ? null : Version.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "version": version == null ? null : version.toJson(),
      };
}

class Version {
  Version({
    this.id,
    this.platform,
    this.version,
    this.update,
  });

  int id;
  String platform;
  int version;
  String update;

  Version copyWith({
    int id,
    String platform,
    int version,
    String update,
  }) =>
      Version(
        id: id ?? this.id,
        platform: platform ?? this.platform,
        version: version ?? this.version,
        update: update ?? this.update,
      );

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        id: json["id"] == null ? null : json["id"],
        platform: json["platform"] == null ? null : json["platform"],
        version: json["version"] == null ? null : json["version"],
        update: json["update"] == null ? null : json["update"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "platform": platform == null ? null : platform,
        "version": version == null ? null : version,
        "update": update == null ? null : update,
      };
}
