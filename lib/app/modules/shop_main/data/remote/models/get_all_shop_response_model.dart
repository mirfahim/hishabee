// To parse this JSON data, do
//
//     final shop = shopFromJson(jsonString);

import 'dart:convert';

List<Shop> shopsFromJson(String str) =>
    List<Shop>.from(json.decode(str).map((x) => Shop.fromJson(x)));

List<Shop> shopsFromRawJson(dynamic json) =>
    List<Shop>.from((json as List<dynamic>).map((x) => Shop.fromJson(x)));

String shopsToJson(List<Shop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

///TODO this model is OK





class Shop {
  Shop({
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.type,
    this.area,
    this.address,
    this.sliders,
    this.lat,
    this.lng,
    this.shopNumber,
    this.floorNumber,
    this.vatPercent,
    this.publicNumber,
    this.logoUrl,
    this.referralCode,
    this.facebook,
    this.instagram,
    this.twitter,
    this.youtube,
    this.setDefault,
    this.createdAt,
    this.updatedAt,
    this.metaTitle,
    this.metaDescription,
    this.pickUpPointId,
    this.tradeLicense,
    this.tin,
    this.public,
    this.active,
    this.onlineShopCreatedAt,
    this.campaignId,
    this.smsCount,
    this.theme,
    this.time,
    this.package,
    this.endDate,
    this.deviceCount,
    this.activeOrder,
    this.onlineProduct,
    this.totalEarning,
    this.totalUnread,
    this.walletBalance,
    this.liquidBalance,
    this.hishabeeCredit,
    this.nidVerified,
    this.campaign,
    this.wallet,
    this.user,
  });

  int id;
  int userId;
  String name;
  String slug;
  int type;
  int area;
  String address;
  Sliders sliders;
  double lat;
  double lng;
  int shopNumber;
  int floorNumber;
  int vatPercent;
  String publicNumber;
  String logoUrl;
  String referralCode;
  String facebook;
  String instagram;
  dynamic twitter;
  String youtube;
  int setDefault;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic pickUpPointId;
  dynamic tradeLicense;
  dynamic tin;
  bool public;
  int active;
  DateTime onlineShopCreatedAt;
  int campaignId;
  int smsCount;
  int theme;
  DateTime time;
  Package package;
  DateTime endDate;
  int deviceCount;
  int activeOrder;
  int onlineProduct;
  int totalEarning;
  int totalUnread;
  double walletBalance;
  double liquidBalance;
  double hishabeeCredit;
  bool nidVerified;
  Campaign campaign;
  Wallet wallet;
  User user;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    slug: json["slug"],
    type: json["type"],
    area: json["area"],
    address: json["address"],
    sliders: json["sliders"] == null ? null : slidersValues.map[json["sliders"]],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    shopNumber: json["shop_number"],
    floorNumber: json["floor_number"],
    vatPercent: json["vat_percent"],
    publicNumber: json["public_number"] == null ? null : json["public_number"],
    logoUrl: json["logo_url"] == null ? null : json["logo_url"],
    referralCode: json["referral_code"],
    facebook: json["facebook"] == null ? null : json["facebook"],
    instagram: json["instagram"] == null ? null : json["instagram"],
    twitter: json["twitter"],
    youtube: json["youtube"] == null ? null : json["youtube"],
    setDefault: json["set_default"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    pickUpPointId: json["pick_up_point_id"],
    tradeLicense: json["trade_license"],
    tin: json["tin"],
    public: json["public"],
    active: json["active"],
    onlineShopCreatedAt: json["online_shop_created_at"] == null ? null : DateTime.parse(json["online_shop_created_at"]),
    campaignId: json["campaign_id"] == null ? null : json["campaign_id"],
    smsCount: json["sms_count"],
    theme: json["theme"],
    time: DateTime.parse(json["time"]),
    package: packageValues.map[json["package"]],
    endDate: DateTime.parse(json["end_date"]),
    deviceCount: json["device_count"],
    activeOrder: json["active_order"],
    onlineProduct: json["online_product"],
    totalEarning: json["total_earning"],
    totalUnread: json["total_unread"],
    walletBalance: json["wallet_balance"].toDouble(),
    liquidBalance: json["liquid_balance"].toDouble(),
    hishabeeCredit: json["hishabee_credit"].toDouble(),
    nidVerified: json["nid_verified"],
    campaign: json["campaign"] == null ? null : Campaign.fromJson(json["campaign"]),
    wallet: Wallet.fromJson(json["wallet"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "slug": slug,
    "type": type,
    "area": area,
    "address": address,
    "sliders": sliders == null ? null : slidersValues.reverse[sliders],
    "lat": lat,
    "lng": lng,
    "shop_number": shopNumber,
    "floor_number": floorNumber,
    "vat_percent": vatPercent,
    "public_number": publicNumber == null ? null : publicNumber,
    "logo_url": logoUrl == null ? null : logoUrl,
    "referral_code": referralCode,
    "facebook": facebook == null ? null : facebook,
    "instagram": instagram == null ? null : instagram,
    "twitter": twitter,
    "youtube": youtube == null ? null : youtube,
    "set_default": setDefault,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "pick_up_point_id": pickUpPointId,
    "trade_license": tradeLicense,
    "tin": tin,
    "public": public,
    "active": active,
    "online_shop_created_at": onlineShopCreatedAt == null ? null : onlineShopCreatedAt.toIso8601String(),
    "campaign_id": campaignId == null ? null : campaignId,
    "sms_count": smsCount,
    "theme": theme,
    "time": time.toIso8601String(),
    "package": packageValues.reverse[package],
    "end_date": endDate.toIso8601String(),
    "device_count": deviceCount,
    "active_order": activeOrder,
    "online_product": onlineProduct,
    "total_earning": totalEarning,
    "total_unread": totalUnread,
    "wallet_balance": walletBalance,
    "liquid_balance": liquidBalance,
    "hishabee_credit": hishabeeCredit,
    "nid_verified": nidVerified,
    "campaign": campaign == null ? null : campaign.toJson(),
    "wallet": wallet.toJson(),
    "user": user.toJson(),
  };
}

class Campaign {
  Campaign({
    this.id,
    this.triggerDayOffset,
    this.name,
    this.duration,
    this.bnDuration,
    this.durationInDays,
    this.package,
    this.regularPrice,
    this.discountPrice,
    this.discountPercent,
    this.campaignTriggerType,
    this.image,
    this.gifts,
    this.cashbackAmount,
    this.hishabeeCreditAmount,
    this.createdAt,
    this.updatedAt,
    this.messageText,
    this.notificationTitle,
    this.notificationDetails,
    this.paymentUrl,
  });

  int id;
  int triggerDayOffset;
  String name;
  String duration;
  String bnDuration;
  int durationInDays;
  Package package;
  int regularPrice;
  int discountPrice;
  int discountPercent;
  String campaignTriggerType;
  String image;
  String gifts;
  int cashbackAmount;
  int hishabeeCreditAmount;
  DateTime createdAt;
  DateTime updatedAt;
  String messageText;
  String notificationTitle;
  String notificationDetails;
  dynamic paymentUrl;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json["id"],
    triggerDayOffset: json["trigger_day_offset"],
    name: json["name"],
    duration: json["duration"],
    bnDuration: json["bn_duration"],
    durationInDays: json["duration_in_days"],
    package: packageValues.map[json["package"]],
    regularPrice: json["regular_price"],
    discountPrice: json["discount_price"],
    discountPercent: json["discount_percent"],
    campaignTriggerType: json["campaign_trigger_type"],
    image: json["image"],
    gifts: json["gifts"],
    cashbackAmount: json["cashback_amount"],
    hishabeeCreditAmount: json["hishabee_credit_amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    messageText: json["message_text"],
    notificationTitle: json["notification_title"],
    notificationDetails: json["notification_details"],
    paymentUrl: json["payment_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trigger_day_offset": triggerDayOffset,
    "name": name,
    "duration": duration,
    "bn_duration": bnDuration,
    "duration_in_days": durationInDays,
    "package": packageValues.reverse[package],
    "regular_price": regularPrice,
    "discount_price": discountPrice,
    "discount_percent": discountPercent,
    "campaign_trigger_type": campaignTriggerType,
    "image": image,
    "gifts": gifts,
    "cashback_amount": cashbackAmount,
    "hishabee_credit_amount": hishabeeCreditAmount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "message_text": messageText,
    "notification_title": notificationTitle,
    "notification_details": notificationDetails,
    "payment_url": paymentUrl,
  };
}

enum Package { FREE, STANDARD, ADVANCED }

final packageValues = EnumValues({
  "ADVANCED": Package.ADVANCED,
  "FREE": Package.FREE,
  "STANDARD": Package.STANDARD
});

enum Sliders { UPLOADS_SLIDERS_SAMPLE_2_PNG }

final slidersValues = EnumValues({
  "[\"uploads/sliders/sample/2.png\"]": Sliders.UPLOADS_SLIDERS_SAMPLE_2_PNG
});

class User {
  User({
    this.id,
    this.userType,
    this.name,
    this.brandName,
    this.email,
    this.emailVerifiedAt,
    this.verifiedAt,
    this.ownerName,
    this.mobileNumber,
    this.website,
    this.logoUrl,
    this.avatar,
    this.avatarOriginal,
    this.address,
    this.postalCode,
    this.balance,
    this.referralCode,
    this.customerPackageId,
    this.remainingUploads,
    this.interest,
    this.verificationCode,
    this.createdAt,
    this.updatedAt,
    this.nidVerified,
    this.nidNumber,
  });

  int id;
  UserType userType;
  Name name;
  Name brandName;
  dynamic email;
  dynamic emailVerifiedAt;
  DateTime verifiedAt;
  dynamic ownerName;
  String mobileNumber;
  dynamic website;
  dynamic logoUrl;
  dynamic avatar;
  dynamic avatarOriginal;
  dynamic address;
  dynamic postalCode;
  int balance;
  dynamic referralCode;
  dynamic customerPackageId;
  int remainingUploads;
  dynamic interest;
  dynamic verificationCode;
  DateTime createdAt;
  DateTime updatedAt;
  int nidVerified;
  String nidNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userType: userTypeValues.map[json["user_type"]],
    name: nameValues.map[json["name"]],
    brandName: nameValues.map[json["brand_name"]],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    verifiedAt: DateTime.parse(json["verified_at"]),
    ownerName: json["owner_name"],
    mobileNumber: json["mobile_number"],
    website: json["website"],
    logoUrl: json["logo_url"],
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
    address: json["address"],
    postalCode: json["postal_code"],
    balance: json["balance"],
    referralCode: json["referral_code"],
    customerPackageId: json["customer_package_id"],
    remainingUploads: json["remaining_uploads"],
    interest: json["interest"],
    verificationCode: json["verification_code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    nidVerified: json["nid_verified"],
    nidNumber: json["nid_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_type": userTypeValues.reverse[userType],
    "name": nameValues.reverse[name],
    "brand_name": nameValues.reverse[brandName],
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "verified_at": verifiedAt.toIso8601String(),
    "owner_name": ownerName,
    "mobile_number": mobileNumber,
    "website": website,
    "logo_url": logoUrl,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "address": address,
    "postal_code": postalCode,
    "balance": balance,
    "referral_code": referralCode,
    "customer_package_id": customerPackageId,
    "remaining_uploads": remainingUploads,
    "interest": interest,
    "verification_code": verificationCode,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "nid_verified": nidVerified,
    "nid_number": nidNumber,
  };
}

enum Name { RAKIN }

final nameValues = EnumValues({
  "Rakin": Name.RAKIN
});

enum UserType { SELLER }

final userTypeValues = EnumValues({
  "seller": UserType.SELLER
});

class Wallet {
  Wallet({
    this.id,
    this.userId,
    this.shopId,
    this.totalBalance,
    this.liquidBalance,
    this.hishabeeGrant,
    this.giftPoints,
    this.walletBarcode,
    this.createdAt,
    this.updatedAt,
    this.hishabeeCredit,
  });

  int id;
  int userId;
  int shopId;
  double totalBalance;
  double liquidBalance;
  int hishabeeGrant;
  int giftPoints;
  dynamic walletBarcode;
  DateTime createdAt;
  DateTime updatedAt;
  double hishabeeCredit;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    totalBalance: json["total_balance"].toDouble(),
    liquidBalance: json["liquid_balance"].toDouble(),
    hishabeeGrant: json["hishabee_grant"],
    giftPoints: json["gift_points"],
    walletBarcode: json["wallet_barcode"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    hishabeeCredit: json["hishabee_credit"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shop_id": shopId,
    "total_balance": totalBalance,
    "liquid_balance": liquidBalance,
    "hishabee_grant": hishabeeGrant,
    "gift_points": giftPoints,
    "wallet_barcode": walletBarcode,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "hishabee_credit": hishabeeCredit,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

