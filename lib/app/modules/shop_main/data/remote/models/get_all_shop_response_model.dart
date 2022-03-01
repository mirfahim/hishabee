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
  int walletBalance;
  int liquidBalance;
  int hishabeeCredit;
  bool nidVerified;
  Campaign campaign;
  Wallet wallet;
  User user;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    type: json["type"] == null ? null : json["type"],
    area: json["area"] == null ? null : json["area"],
    address: json["address"] == null ? null : json["address"],
    sliders: json["sliders"] == null ? null : slidersValues.map[json["sliders"]],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
    shopNumber: json["shop_number"] == null ? null : json["shop_number"],
    floorNumber: json["floor_number"] == null ? null : json["floor_number"],
    vatPercent: json["vat_percent"] == null ? null : json["vat_percent"],
    publicNumber: json["public_number"] == null ? null : json["public_number"],
    logoUrl: json["logo_url"] == null ? null : json["logo_url"],
    referralCode: json["referral_code"] == null ? null : json["referral_code"],
    facebook: json["facebook"] == null ? null : json["facebook"],
    instagram: json["instagram"] == null ? null : json["instagram"],
    twitter: json["twitter"],
    youtube: json["youtube"] == null ? null : json["youtube"],
    setDefault: json["set_default"] == null ? null : json["set_default"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    pickUpPointId: json["pick_up_point_id"],
    tradeLicense: json["trade_license"],
    tin: json["tin"],
    public: json["public"] == null ? null : json["public"],
    active: json["active"] == null ? null : json["active"],
    onlineShopCreatedAt: json["online_shop_created_at"] == null ? null : DateTime.parse(json["online_shop_created_at"]),
    campaignId: json["campaign_id"] == null ? null : json["campaign_id"],
    smsCount: json["sms_count"] == null ? null : json["sms_count"],
    theme: json["theme"] == null ? null : json["theme"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    package: json["package"] == null ? null : packageValues.map[json["package"]],
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    deviceCount: json["device_count"] == null ? null : json["device_count"],
    activeOrder: json["active_order"] == null ? null : json["active_order"],
    onlineProduct: json["online_product"] == null ? null : json["online_product"],
    totalEarning: json["total_earning"] == null ? null : json["total_earning"],
    totalUnread: json["total_unread"] == null ? null : json["total_unread"],
    walletBalance: json["wallet_balance"] == null ? null : json["wallet_balance"],
    liquidBalance: json["liquid_balance"] == null ? null : json["liquid_balance"],
    hishabeeCredit: json["hishabee_credit"] == null ? null : json["hishabee_credit"],
    nidVerified: json["nid_verified"] == null ? null : json["nid_verified"],
    campaign: json["campaign"] == null ? null : Campaign.fromJson(json["campaign"]),
    wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "type": type == null ? null : type,
    "area": area == null ? null : area,
    "address": address == null ? null : address,
    "sliders": sliders == null ? null : slidersValues.reverse[sliders],
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "shop_number": shopNumber == null ? null : shopNumber,
    "floor_number": floorNumber == null ? null : floorNumber,
    "vat_percent": vatPercent == null ? null : vatPercent,
    "public_number": publicNumber == null ? null : publicNumber,
    "logo_url": logoUrl == null ? null : logoUrl,
    "referral_code": referralCode == null ? null : referralCode,
    "facebook": facebook == null ? null : facebook,
    "instagram": instagram == null ? null : instagram,
    "twitter": twitter,
    "youtube": youtube == null ? null : youtube,
    "set_default": setDefault == null ? null : setDefault,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "pick_up_point_id": pickUpPointId,
    "trade_license": tradeLicense,
    "tin": tin,
    "public": public == null ? null : public,
    "active": active == null ? null : active,
    "online_shop_created_at": onlineShopCreatedAt == null ? null : onlineShopCreatedAt.toIso8601String(),
    "campaign_id": campaignId == null ? null : campaignId,
    "sms_count": smsCount == null ? null : smsCount,
    "theme": theme == null ? null : theme,
    "time": time == null ? null : time.toIso8601String(),
    "package": package == null ? null : packageValues.reverse[package],
    "end_date": endDate == null ? null : endDate.toIso8601String(),
    "device_count": deviceCount == null ? null : deviceCount,
    "active_order": activeOrder == null ? null : activeOrder,
    "online_product": onlineProduct == null ? null : onlineProduct,
    "total_earning": totalEarning == null ? null : totalEarning,
    "total_unread": totalUnread == null ? null : totalUnread,
    "wallet_balance": walletBalance == null ? null : walletBalance,
    "liquid_balance": liquidBalance == null ? null : liquidBalance,
    "hishabee_credit": hishabeeCredit == null ? null : hishabeeCredit,
    "nid_verified": nidVerified == null ? null : nidVerified,
    "campaign": campaign == null ? null : campaign.toJson(),
    "wallet": wallet == null ? null : wallet.toJson(),
    "user": user == null ? null : user.toJson(),
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
    id: json["id"] == null ? null : json["id"],
    triggerDayOffset: json["trigger_day_offset"] == null ? null : json["trigger_day_offset"],
    name: json["name"] == null ? null : json["name"],
    duration: json["duration"] == null ? null : json["duration"],
    bnDuration: json["bn_duration"] == null ? null : json["bn_duration"],
    durationInDays: json["duration_in_days"] == null ? null : json["duration_in_days"],
    package: json["package"] == null ? null : packageValues.map[json["package"]],
    regularPrice: json["regular_price"] == null ? null : json["regular_price"],
    discountPrice: json["discount_price"] == null ? null : json["discount_price"],
    discountPercent: json["discount_percent"] == null ? null : json["discount_percent"],
    campaignTriggerType: json["campaign_trigger_type"] == null ? null : json["campaign_trigger_type"],
    image: json["image"] == null ? null : json["image"],
    gifts: json["gifts"] == null ? null : json["gifts"],
    cashbackAmount: json["cashback_amount"] == null ? null : json["cashback_amount"],
    hishabeeCreditAmount: json["hishabee_credit_amount"] == null ? null : json["hishabee_credit_amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    messageText: json["message_text"] == null ? null : json["message_text"],
    notificationTitle: json["notification_title"] == null ? null : json["notification_title"],
    notificationDetails: json["notification_details"] == null ? null : json["notification_details"],
    paymentUrl: json["payment_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "trigger_day_offset": triggerDayOffset == null ? null : triggerDayOffset,
    "name": name == null ? null : name,
    "duration": duration == null ? null : duration,
    "bn_duration": bnDuration == null ? null : bnDuration,
    "duration_in_days": durationInDays == null ? null : durationInDays,
    "package": package == null ? null : packageValues.reverse[package],
    "regular_price": regularPrice == null ? null : regularPrice,
    "discount_price": discountPrice == null ? null : discountPrice,
    "discount_percent": discountPercent == null ? null : discountPercent,
    "campaign_trigger_type": campaignTriggerType == null ? null : campaignTriggerType,
    "image": image == null ? null : image,
    "gifts": gifts == null ? null : gifts,
    "cashback_amount": cashbackAmount == null ? null : cashbackAmount,
    "hishabee_credit_amount": hishabeeCreditAmount == null ? null : hishabeeCreditAmount,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "message_text": messageText == null ? null : messageText,
    "notification_title": notificationTitle == null ? null : notificationTitle,
    "notification_details": notificationDetails == null ? null : notificationDetails,
    "payment_url": paymentUrl,
  };
}

enum Package { ADVANCED, STANDARD, FREE }

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
    id: json["id"] == null ? null : json["id"],
    userType: json["user_type"] == null ? null : userTypeValues.map[json["user_type"]],
    name: json["name"] == null ? null : nameValues.map[json["name"]],
    brandName: json["brand_name"] == null ? null : nameValues.map[json["brand_name"]],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    verifiedAt: json["verified_at"] == null ? null : DateTime.parse(json["verified_at"]),
    ownerName: json["owner_name"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    website: json["website"],
    logoUrl: json["logo_url"],
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
    address: json["address"],
    postalCode: json["postal_code"],
    balance: json["balance"] == null ? null : json["balance"],
    referralCode: json["referral_code"],
    customerPackageId: json["customer_package_id"],
    remainingUploads: json["remaining_uploads"] == null ? null : json["remaining_uploads"],
    interest: json["interest"],
    verificationCode: json["verification_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    nidVerified: json["nid_verified"] == null ? null : json["nid_verified"],
    nidNumber: json["nid_number"] == null ? null : json["nid_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_type": userType == null ? null : userTypeValues.reverse[userType],
    "name": name == null ? null : nameValues.reverse[name],
    "brand_name": brandName == null ? null : nameValues.reverse[brandName],
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "verified_at": verifiedAt == null ? null : verifiedAt.toIso8601String(),
    "owner_name": ownerName,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "website": website,
    "logo_url": logoUrl,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "address": address,
    "postal_code": postalCode,
    "balance": balance == null ? null : balance,
    "referral_code": referralCode,
    "customer_package_id": customerPackageId,
    "remaining_uploads": remainingUploads == null ? null : remainingUploads,
    "interest": interest,
    "verification_code": verificationCode,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "nid_verified": nidVerified == null ? null : nidVerified,
    "nid_number": nidNumber == null ? null : nidNumber,
  };
}

enum Name { EMPTY }

final nameValues = EnumValues({
  "নুরজাহান ক্রোকারিজ": Name.EMPTY
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
  int totalBalance;
  int liquidBalance;
  int hishabeeGrant;
  int giftPoints;
  dynamic walletBarcode;
  DateTime createdAt;
  DateTime updatedAt;
  int hishabeeCredit;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    totalBalance: json["total_balance"] == null ? null : json["total_balance"],
    liquidBalance: json["liquid_balance"] == null ? null : json["liquid_balance"],
    hishabeeGrant: json["hishabee_grant"] == null ? null : json["hishabee_grant"],
    giftPoints: json["gift_points"] == null ? null : json["gift_points"],
    walletBarcode: json["wallet_barcode"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    hishabeeCredit: json["hishabee_credit"] == null ? null : json["hishabee_credit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "shop_id": shopId == null ? null : shopId,
    "total_balance": totalBalance == null ? null : totalBalance,
    "liquid_balance": liquidBalance == null ? null : liquidBalance,
    "hishabee_grant": hishabeeGrant == null ? null : hishabeeGrant,
    "gift_points": giftPoints == null ? null : giftPoints,
    "wallet_barcode": walletBarcode,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "hishabee_credit": hishabeeCredit == null ? null : hishabeeCredit,
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
