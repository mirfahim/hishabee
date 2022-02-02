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
class FcmToken {
  FcmToken({
    this.id,
    this.userId,
    this.notificationKeyName,
    this.notificationKey,
    this.registrationIds,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String notificationKeyName;
  String notificationKey;
  String registrationIds;
  DateTime createdAt;
  DateTime updatedAt;

  FcmToken copyWith({
    int id,
    int userId,
    String notificationKeyName,
    String notificationKey,
    String registrationIds,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      FcmToken(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        notificationKeyName: notificationKeyName ?? this.notificationKeyName,
        notificationKey: notificationKey ?? this.notificationKey,
        registrationIds: registrationIds ?? this.registrationIds,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory FcmToken.fromJson(Map<String, dynamic> json) => FcmToken(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        notificationKeyName: json["notification_key_name"] == null
            ? null
            : json["notification_key_name"],
        notificationKey:
            json["notification_key"] == null ? null : json["notification_key"],
        registrationIds:
            json["registration_ids"] == null ? null : json["registration_ids"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "notification_key_name":
            notificationKeyName == null ? null : notificationKeyName,
        "notification_key": notificationKey == null ? null : notificationKey,
        "registration_ids": registrationIds == null ? null : registrationIds,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
