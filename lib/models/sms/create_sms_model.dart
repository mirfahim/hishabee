// To parse this JSON data, do
//
//     final createSms = createSmsFromJson(jsonString);

import 'dart:convert';

List<CreateSms> getSmsFromModel(dynamic str) =>
    List<CreateSms>.from(str.map((x) => CreateSms.fromJson(x)));

CreateSms createSmsFromJson(String str) => CreateSms.fromJson(json.decode(str));

String createSmsToJson(CreateSms data) => json.encode(data.toJson());

class CreateSms {
  CreateSms({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory CreateSms.fromJson(Map<String, dynamic> json) => CreateSms(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
