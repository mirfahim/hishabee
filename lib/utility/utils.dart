import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/bank_model.dart';

enum apiMethods { get, post, patch, delete }

class Utils {
  static final month3fee = 0.05;
  static final month6fee = 0.07;
  static final month9fee = 0.09;
  static final month12fee = 0.12;
  static final month18fee = 0.15;
  static final month24fee = 0.19;
  static final month30fee = 0.20;
  static final month36fee = 0.21;

  static List<BankModel> bankList = [
    BankModel(
        name: "Standard Chartered Bank",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: Utils.month36fee),
    BankModel(
        name: "City Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: Utils.month30fee,
        month36Fee: Utils.month36fee),
    BankModel(
        name: "Eastern Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: Utils.month36fee),
    BankModel(
        name: "BRAC Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "Dutch Bangla Bank ",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: Utils.month36fee),
    BankModel(
        name: "Mutual Trust Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: Utils.month36fee),
    BankModel(
        name: "Southeast Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "Standard Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "Standard Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "NCC Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: Utils.month36fee),
    BankModel(
        name: "NRB Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: Utils.month36fee),
    BankModel(
        name: "Meghna Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "Jamuna Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: Utils.month36fee),
    BankModel(
      name: "Midland Bank Limited",
      month3Fee: Utils.month3fee,
      month6Fee: Utils.month6fee,
      month9Fee: Utils.month9fee,
      month12Fee: Utils.month12fee,
      month18Fee: Utils.month18fee,
      month24Fee: Utils.month24fee,
      month30Fee: null,
      month36Fee: null,
    ),
    BankModel(
        name: "Bank Asia Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: null,
        month24Fee: null,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "Dhaka Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: null,
        month24Fee: null,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "LankaBangla Financial Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "NRB Commercial",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "Shahjalal Islami Bank Limited (SJIBL)",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: null,
        month24Fee: null,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "EXIM Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: null,
        month24Fee: null,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "PRIME Bank Limited",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "UNITED COMMERCIAL BANK",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: null,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
    BankModel(
        name: "SBAC Bank",
        month3Fee: Utils.month3fee,
        month6Fee: Utils.month6fee,
        month9Fee: Utils.month9fee,
        month12Fee: Utils.month12fee,
        month18Fee: Utils.month18fee,
        month24Fee: Utils.month24fee,
        month30Fee: null,
        month36Fee: null),
  ];
  static showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static getPaddingBothSide() =>
      EdgeInsets.symmetric(vertical: 0, horizontal: 20);

  static getBoxShape() => BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey[400], width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(6.0)));
}
