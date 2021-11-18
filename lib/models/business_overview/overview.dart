// To parse this JSON data, do
//
//     final overviewModel = overviewModelFromJson(jsonString);

import 'dart:convert';

OverviewModel overviewModelFromJson(Map<String, dynamic> json) =>
    OverviewModel.fromJson(json);

class OverviewModel {
  OverviewModel({
    this.totalProduct,
    this.totalProductAmount,
    this.totalCollected,
    this.totalProfit,
    this.totalExpense,
    this.totalDue,
  });

  int totalProduct;
  int totalProductAmount;
  int totalCollected;
  int totalProfit;
  int totalExpense;
  int totalDue;

  factory OverviewModel.fromJson(Map<String, dynamic> json) => OverviewModel(
        totalProduct: json["total_product"] ?? "0",
        totalProductAmount: json["total_product_amount"] ?? "0",
        totalCollected: json["total_collected"] ?? "0",
        totalProfit: json["total_profit"] ?? "0",
        totalExpense: json["total_expense"] ?? "0",
        totalDue: json["total_due"] ?? "0",
      );
}
