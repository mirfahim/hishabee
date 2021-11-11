// To parse this JSON data, do
//
//     final resendOtpResponseModel = resendOtpResponseModelFromJson(jsonString);

import 'dart:convert';

OtpResponseModel otpResponseModelFromJson(String str) =>
    OtpResponseModel.fromJson(json.decode(str));

OtpResponseModel otpResponseModelRawJson(dynamic map) =>
    OtpResponseModel.fromJson(map);

String otpResponseModelToJson(OtpResponseModel data) =>
    json.encode(data.toJson());

class OtpResponseModel {
  OtpResponseModel({
    this.code,
    this.message,
  });

  int code;
  MessageModel message;

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpResponseModel(
        code: json["code"],
        message: MessageModel.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message.toJson(),
      };
}

class MessageModel {
  MessageModel({
    this.data,
    this.errorString,
    this.timestamp,
  });

  List<DataModel> data;
  dynamic errorString;
  int timestamp;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        data: List<DataModel>.from(
            json["data"].map((x) => DataModel.fromJson(x))),
        errorString: json["error_string"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error_string": errorString,
        "timestamp": timestamp,
      };
}

class DataModel {
  DataModel({
    this.status,
    this.error,
    this.smslogId,
    this.queue,
    this.to,
  });

  String status;
  String error;
  String smslogId;
  String queue;
  String to;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        status: json["status"],
        error: json["error"],
        smslogId: json["smslog_id"],
        queue: json["queue"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "smslog_id": smslogId,
        "queue": queue,
        "to": to,
      };
}
