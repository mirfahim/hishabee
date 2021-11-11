// To parse this JSON data, do
//
//     final subscriptionItem = subscriptionItemFromJson(jsonString);

import 'dart:convert';

List<SubscriptionItem> subscriptionItemFromJson(String str) => List<SubscriptionItem>.from(json.decode(str).map((x) => SubscriptionItem.fromJson(x)));
List<SubscriptionItem> subscriptionItemFromRawJson(dynamic json) => List<SubscriptionItem>.from((json as List<dynamic>).map((x) => SubscriptionItem.fromJson(x)));

String subscriptionItemToJson(List<SubscriptionItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionItem {
  SubscriptionItem({
    this.id,
    this.subscriptionId,
    this.shopId,
    this.duration,
    this.amountPaid,
    this.package,
    this.createdAt,
    this.updatedAt,
    this.startDate,
    this.endDate,
    this.subscriptionPackageId,
    this.campaignId,
    this.trxId,
  });

  int id;
  int subscriptionId;
  int shopId;
  int duration;
  int amountPaid;
  String package;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime startDate;
  DateTime endDate;
  int subscriptionPackageId;
  dynamic campaignId;
  dynamic trxId;

  SubscriptionItem copyWith({
    int id,
    int subscriptionId,
    int shopId,
    int duration,
    int amountPaid,
    String package,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime startDate,
    DateTime endDate,
    int subscriptionPackageId,
    dynamic campaignId,
    dynamic trxId,
  }) =>
      SubscriptionItem(
        id: id ?? this.id,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        shopId: shopId ?? this.shopId,
        duration: duration ?? this.duration,
        amountPaid: amountPaid ?? this.amountPaid,
        package: package ?? this.package,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        subscriptionPackageId: subscriptionPackageId ?? this.subscriptionPackageId,
        campaignId: campaignId ?? this.campaignId,
        trxId: trxId ?? this.trxId,
      );

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) => SubscriptionItem(
    id: json["id"] == null ? null : json["id"],
    subscriptionId: json["subscription_id"] == null ? null : json["subscription_id"],
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    duration: json["duration"] == null ? null : json["duration"],
    amountPaid: json["amount_paid"] == null ? null : json["amount_paid"],
    package: json["package"] == null ? null : json["package"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    subscriptionPackageId: json["subscription_package_id"] == null ? null : json["subscription_package_id"],
    campaignId: json["campaign_id"],
    trxId: json["trx_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "subscription_id": subscriptionId == null ? null : subscriptionId,
    "shop_id": shopId == null ? null : shopId,
    "duration": duration == null ? null : duration,
    "amount_paid": amountPaid == null ? null : amountPaid,
    "package": package == null ? null : package,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "start_date": startDate == null ? null : startDate.toIso8601String(),
    "end_date": endDate == null ? null : endDate.toIso8601String(),
    "subscription_package_id": subscriptionPackageId == null ? null : subscriptionPackageId,
    "campaign_id": campaignId,
    "trx_id": trxId,
  };
}