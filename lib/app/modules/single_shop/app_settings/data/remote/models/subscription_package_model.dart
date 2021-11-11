// To parse this JSON data, do
//
//     final subscriptionPackageResponseModel = subscriptionPackageResponseModelFromJson(jsonString);

import 'dart:convert';

List<SubscriptionPackageResponseModel> subscriptionPackageResponseModelFromJson(
        String str) =>
    List<SubscriptionPackageResponseModel>.from(json
        .decode(str)
        .map((x) => SubscriptionPackageResponseModel.fromJson(x)));
List<SubscriptionPackageResponseModel>
    subscriptionPackageResponseModelFromRawJson(dynamic json) =>
        List<SubscriptionPackageResponseModel>.from((json as List<dynamic>)
            .map((x) => SubscriptionPackageResponseModel.fromJson(x)));

String subscriptionPackageResponseModelToJson(
        List<SubscriptionPackageResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionPackageResponseModel {
  SubscriptionPackageResponseModel({
    this.id,
    this.duration,
    this.bnDuration,
    this.durationInDays,
    this.package,
    this.price,
    this.discountPercent,
    this.priceAfterDiscount,
    this.popularity,
    this.bnPopularity,
    this.gifts,
    this.createdAt,
    this.updatedAt,
    this.orderIndex,
    this.cashbackAmount,
    this.hishabeeCreditAmount,
  });

  int id;
  String duration;
  String bnDuration;
  int durationInDays;
  String package;
  int price;
  int discountPercent;
  int priceAfterDiscount;
  String popularity;
  String bnPopularity;
  String gifts;
  DateTime createdAt;
  DateTime updatedAt;
  int orderIndex;
  int cashbackAmount;
  int hishabeeCreditAmount;

  SubscriptionPackageResponseModel copyWith({
    int id,
    String duration,
    String bnDuration,
    int durationInDays,
    String package,
    int price,
    int discountPercent,
    int priceAfterDiscount,
    String popularity,
    String bnPopularity,
    String gifts,
    DateTime createdAt,
    DateTime updatedAt,
    int orderIndex,
    int cashbackAmount,
    int hishabeeCreditAmount,
  }) =>
      SubscriptionPackageResponseModel(
        id: id ?? this.id,
        duration: duration ?? this.duration,
        bnDuration: bnDuration ?? this.bnDuration,
        durationInDays: durationInDays ?? this.durationInDays,
        package: package ?? this.package,
        price: price ?? this.price,
        discountPercent: discountPercent ?? this.discountPercent,
        priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
        popularity: popularity ?? this.popularity,
        bnPopularity: bnPopularity ?? this.bnPopularity,
        gifts: gifts ?? this.gifts,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        orderIndex: orderIndex ?? this.orderIndex,
        cashbackAmount: cashbackAmount ?? this.cashbackAmount,
        hishabeeCreditAmount: hishabeeCreditAmount ?? this.hishabeeCreditAmount,
      );

  factory SubscriptionPackageResponseModel.fromJson(
          Map<String, dynamic> json) =>
      SubscriptionPackageResponseModel(
        id: json["id"] == null ? null : json["id"],
        duration: json["duration"] == null ? null : json["duration"],
        bnDuration: json["bn_duration"] == null ? null : json["bn_duration"],
        durationInDays:
            json["duration_in_days"] == null ? null : json["duration_in_days"],
        package: json["package"] == null ? null : json["package"],
        price: json["price"] == null ? null : json["price"],
        discountPercent:
            json["discount_percent"] == null ? null : json["discount_percent"],
        priceAfterDiscount: json["price_after_discount"] == null
            ? null
            : json["price_after_discount"],
        popularity: json["popularity"] == null ? null : json["popularity"],
        bnPopularity:
            json["bn_popularity"] == null ? null : json["bn_popularity"],
        gifts: json["gifts"] == null ? null : json["gifts"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderIndex: json["order_index"] == null ? null : json["order_index"],
        cashbackAmount:
            json["cashback_amount"] == null ? null : json["cashback_amount"],
        hishabeeCreditAmount: json["hishabee_credit_amount"] == null
            ? null
            : json["hishabee_credit_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "duration": duration == null ? null : duration,
        "bn_duration": bnDuration == null ? null : bnDuration,
        "duration_in_days": durationInDays == null ? null : durationInDays,
        "package": package == null ? null : package,
        "price": price == null ? null : price,
        "discount_percent": discountPercent == null ? null : discountPercent,
        "price_after_discount":
            priceAfterDiscount == null ? null : priceAfterDiscount,
        "popularity": popularity == null ? null : popularity,
        "bn_popularity": bnPopularity == null ? null : bnPopularity,
        "gifts": gifts == null ? null : gifts,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "order_index": orderIndex == null ? null : orderIndex,
        "cashback_amount": cashbackAmount == null ? null : cashbackAmount,
        "hishabee_credit_amount":
            hishabeeCreditAmount == null ? null : hishabeeCreditAmount,
      };
}
