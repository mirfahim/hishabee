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
    this.fcmToken,
  });

  int id;
  String userType;
  String name;
  String brandName;
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
  FcmToken fcmToken;

  User copyWith({
    int id,
    String userType,
    String name,
    String brandName,
    dynamic email,
    dynamic emailVerifiedAt,
    DateTime verifiedAt,
    dynamic ownerName,
    String mobileNumber,
    dynamic website,
    dynamic logoUrl,
    dynamic avatar,
    dynamic avatarOriginal,
    dynamic address,
    dynamic postalCode,
    int balance,
    dynamic referralCode,
    dynamic customerPackageId,
    int remainingUploads,
    dynamic interest,
    dynamic verificationCode,
    DateTime createdAt,
    DateTime updatedAt,
    int nidVerified,
    String nidNumber,
    FcmToken fcmToken,
  }) =>
      User(
        id: id ?? this.id,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        brandName: brandName ?? this.brandName,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        verifiedAt: verifiedAt ?? this.verifiedAt,
        ownerName: ownerName ?? this.ownerName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        website: website ?? this.website,
        logoUrl: logoUrl ?? this.logoUrl,
        avatar: avatar ?? this.avatar,
        avatarOriginal: avatarOriginal ?? this.avatarOriginal,
        address: address ?? this.address,
        postalCode: postalCode ?? this.postalCode,
        balance: balance ?? this.balance,
        referralCode: referralCode ?? this.referralCode,
        customerPackageId: customerPackageId ?? this.customerPackageId,
        remainingUploads: remainingUploads ?? this.remainingUploads,
        interest: interest ?? this.interest,
        verificationCode: verificationCode ?? this.verificationCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nidVerified: nidVerified ?? this.nidVerified,
        nidNumber: nidNumber ?? this.nidNumber,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        userType: json["user_type"] == null ? null : json["user_type"],
        name: json["name"] == null ? null : json["name"],
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        verifiedAt: json["verified_at"] == null
            ? null
            : DateTime.parse(json["verified_at"]),
        ownerName: json["owner_name"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        website: json["website"],
        logoUrl: json["logo_url"],
        avatar: json["avatar"],
        avatarOriginal: json["avatar_original"],
        address: json["address"],
        postalCode: json["postal_code"],
        balance: json["balance"] == null ? null : json["balance"],
        referralCode: json["referral_code"],
        customerPackageId: json["customer_package_id"],
        remainingUploads: json["remaining_uploads"] == null
            ? null
            : json["remaining_uploads"],
        interest: json["interest"],
        verificationCode: json["verification_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        nidVerified: json["nid_verified"] == null ? null : json["nid_verified"],
        nidNumber: json["nid_number"] == null ? null : json["nid_number"],
        fcmToken: json["fcm_token"] == null
            ? null
            : FcmToken.fromJson(json["fcm_token"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_type": userType == null ? null : userType,
        "name": name == null ? null : name,
        "brand_name": brandName == null ? null : brandName,
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
        "fcm_token": fcmToken == null ? null : fcmToken.toJson(),
      };
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
