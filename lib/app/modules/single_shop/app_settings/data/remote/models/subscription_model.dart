import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';

class Subscription {
  Subscription({
    this.id,
    this.shopId,
    this.package,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.shop,
  });

  int id;
  int shopId;
  String package;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  Shop shop;

  Subscription copyWith({
    int id,
    int shopId,
    String package,
    DateTime endDate,
    DateTime createdAt,
    DateTime updatedAt,
    Shop shop,
  }) =>
      Subscription(
        id: id ?? this.id,
        shopId: shopId ?? this.shopId,
        package: package ?? this.package,
        endDate: endDate ?? this.endDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        shop: shop ?? this.shop,
      );

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"] == null ? null : json["id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        package: json["package"] == null ? null : json["package"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "shop_id": shopId == null ? null : shopId,
        "package": package == null ? null : package,
        "end_date": endDate == null ? null : endDate.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "shop": shop == null ? null : shop.toJson(),
      };
}

/*
class SubscriptionItem {
  SubscriptionItem({
    this.shopId,
    this.subscriptionId,
    this.duration,
    this.amountPaid,
    this.package,
    this.startDate,
    this.endDate,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int shopId;
  int subscriptionId;
  int duration;
  num amountPaid;
  String package;
  DateTime startDate;
  DateTime endDate;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  SubscriptionItem copyWith({
    int shopId,
    int subscriptionId,
    String duration,
    String amountPaid,
    String package,
    DateTime startDate,
    DateTime endDate,
    DateTime updatedAt,
    DateTime createdAt,
    int id,
  }) =>
      SubscriptionItem(
        shopId: shopId ?? this.shopId,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        duration: duration ?? this.duration,
        amountPaid: amountPaid ?? this.amountPaid,
        package: package ?? this.package,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) {
    print("RESP: $json");

    return SubscriptionItem(
      shopId: json["shop_id"] == null ? null : json["shop_id"],
      subscriptionId:
      json["subscription_id"] == null ? null : json["subscription_id"],
      duration: json["duration"] == null ? null : json["duration"],
      amountPaid: json["amount_paid"] == null ? null : json["amount_paid"],
      package: json["package"] == null ? null : json["package"],
      startDate: json["start_date"] == null
          ? null
          : DateTime.parse(json["start_date"]),
      endDate:
      json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      id: json["id"] == null ? null : json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "shop_id": shopId == null ? null : shopId,
    "subscription_id": subscriptionId == null ? null : subscriptionId,
    "duration": duration == null ? null : duration,
    "amount_paid": amountPaid == null ? null : amountPaid,
    "package": package == null ? null : package,
    "start_date": startDate == null ? null : startDate.toIso8601String(),
    "end_date": endDate == null ? null : endDate.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "id": id == null ? null : id,
  };
}*/
