import 'dart:convert';

List<BankModel> bankModelFromJson(String str) =>
    List<BankModel>.from(json.decode(str).map((x) => BankModel.fromJson(x)));

class BankModel {
  BankModel({
    this.name,
    this.month3Fee,
    this.month6Fee,
    this.month9Fee,
    this.month12Fee,
    this.month18Fee,
    this.month24Fee,
    this.month30Fee,
    this.month36Fee,
  });

  String name;
  var month3Fee;
  var month6Fee;
  var month9Fee;
  var month12Fee;
  var month18Fee;
  var month24Fee;
  var month30Fee;
  var month36Fee;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        name: json["name"],
        month3Fee: json["month3fee"],
        month6Fee: json["month6fee"],
        month9Fee: json["month9fee"],
        month12Fee: json["month12fee"],
        month18Fee: json["month18fee"],
        month24Fee: json["month24fee"],
        month30Fee: json["month30fee"],
        month36Fee: json["month36fee"],
      );
}
