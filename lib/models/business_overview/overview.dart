// To parse this JSON data, do
//
//     final overviewModel = overviewModelFromJson(jsonString);

import 'dart:convert';

OverviewModel overviewModelFromJson(String str) =>
    OverviewModel.fromJson(json.decode(str));

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
        totalProduct: json["total_product"],
        totalProductAmount: json["total_product_amount"],
        totalCollected: json["total_collected"],
        totalProfit: json["total_profit"],
        totalExpense: json["total_expense"],
        totalDue: json["total_due"],
      );
}
