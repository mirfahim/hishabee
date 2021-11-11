// To parse this JSON data, do
//
//     final onlineOrder = onlineOrderFromJson(jsonString);

import 'dart:convert';

List<OnlineOrder> onlineOrdersFromJson(String str) => List<OnlineOrder>.from(
    json.decode(str).map((x) => OnlineOrder.fromJson(x)));

List<OnlineOrder> onlineOrdersFromRawJson(dynamic json) =>
    List<OnlineOrder>.from(
        (json as List<dynamic>).map((x) => OnlineOrder.fromJson(x)));

OnlineOrder onlineOrderFromMap(dynamic map) => OnlineOrder.fromJson(map);

String onlineOrderToJson(List<OnlineOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnlineOrder {
  OnlineOrder({
    this.id,
    this.userId,
    this.guestId,
    this.shippingAddress,
    this.paymentType,
    this.paymentStatus,
    this.paymentDetails,
    this.grandTotal,
    this.couponDiscount,
    this.code,
    this.date,
    this.viewed,
    this.deliveryViewed,
    this.paymentStatusViewed,
    this.commissionCalculated,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.shippingCost,
    this.orderDetails,
  });

  int id;
  dynamic userId;
  int guestId;
  ShippingAddress shippingAddress;
  String paymentType;
  String paymentStatus;
  PaymentDetails paymentDetails;
  num grandTotal;
  int couponDiscount;
  String code;
  int date;
  int viewed;
  int deliveryViewed;
  int paymentStatusViewed;
  int commissionCalculated;
  DateTime createdAt;
  DateTime updatedAt;
  num service;
  int shippingCost;
  List<OrderDetail> orderDetails;

  OnlineOrder copyWith({
    int id,
    dynamic userId,
    int guestId,
    ShippingAddress shippingAddress,
    String paymentType,
    String paymentStatus,
    PaymentDetails paymentDetails,
    int grandTotal,
    int couponDiscount,
    String code,
    int date,
    int viewed,
    int deliveryViewed,
    int paymentStatusViewed,
    int commissionCalculated,
    DateTime createdAt,
    DateTime updatedAt,
    int service,
    int shippingCost,
    List<OrderDetail> orderDetails,
  }) =>
      OnlineOrder(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        guestId: guestId ?? this.guestId,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        paymentType: paymentType ?? this.paymentType,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentDetails: paymentDetails ?? this.paymentDetails,
        grandTotal: grandTotal ?? this.grandTotal,
        couponDiscount: couponDiscount ?? this.couponDiscount,
        code: code ?? this.code,
        date: date ?? this.date,
        viewed: viewed ?? this.viewed,
        deliveryViewed: deliveryViewed ?? this.deliveryViewed,
        paymentStatusViewed: paymentStatusViewed ?? this.paymentStatusViewed,
        commissionCalculated: commissionCalculated ?? this.commissionCalculated,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        service: service ?? this.service,
        shippingCost: shippingCost ?? this.shippingCost,
        orderDetails: orderDetails ?? this.orderDetails,
      );

  factory OnlineOrder.fromJson(Map<String, dynamic> json) => OnlineOrder(
        id: json["id"],
        userId: json["user_id"],
        guestId: json["guest_id"],
        shippingAddress: ShippingAddress.fromJson(jsonDecode(
            json["shipping_address"].toString().replaceAll("\\", ""))),
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        paymentDetails: json["payment_details"] == null
            ? null
            : PaymentDetails.fromJson(jsonDecode(
                json["payment_details"].toString().replaceAll("\\", ""))),
        grandTotal: json["grand_total"],
        couponDiscount: json["coupon_discount"],
        code: json["code"],
        date: json["date"],
        viewed: json["viewed"],
        deliveryViewed: json["delivery_viewed"],
        paymentStatusViewed: json["payment_status_viewed"],
        commissionCalculated: json["commission_calculated"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        service: json["service"],
        shippingCost: json["shipping_cost"],
        orderDetails: List<OrderDetail>.from(
            json["order_details"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "guest_id": guestId,
        "shipping_address": shippingAddress.toJson(),
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "payment_details": paymentDetails.toJson(),
        "grand_total": grandTotal,
        "coupon_discount": couponDiscount,
        "code": code,
        "date": date,
        "viewed": viewed,
        "delivery_viewed": deliveryViewed,
        "payment_status_viewed": paymentStatusViewed,
        "commission_calculated": commissionCalculated,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service": service,
        "shipping_cost": shippingCost,
        "order_details":
            List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.shopId,
    this.orderId,
    this.sellerId,
    this.productId,
    this.variation,
    this.price,
    this.vat,
    this.shippingCost,
    this.quantity,
    this.paymentStatus,
    this.deliveryStatus,
    this.shippingType,
    this.pickupPointId,
    this.productReferralCode,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int shopId;
  int orderId;
  int sellerId;
  int productId;
  String variation;
  int price;
  int vat;
  int shippingCost;
  int quantity;
  String paymentStatus;
  String deliveryStatus;
  String shippingType;
  dynamic pickupPointId;
  dynamic productReferralCode;
  DateTime createdAt;
  DateTime updatedAt;

  OrderDetail copyWith({
    int id,
    int shopId,
    int orderId,
    int sellerId,
    int productId,
    String variation,
    int price,
    int vat,
    int shippingCost,
    int quantity,
    String paymentStatus,
    String deliveryStatus,
    String shippingType,
    dynamic pickupPointId,
    dynamic productReferralCode,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      OrderDetail(
        id: id ?? this.id,
        shopId: shopId ?? this.shopId,
        orderId: orderId ?? this.orderId,
        sellerId: sellerId ?? this.sellerId,
        productId: productId ?? this.productId,
        variation: variation ?? this.variation,
        price: price ?? this.price,
        vat: vat ?? this.vat,
        shippingCost: shippingCost ?? this.shippingCost,
        quantity: quantity ?? this.quantity,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        shippingType: shippingType ?? this.shippingType,
        pickupPointId: pickupPointId ?? this.pickupPointId,
        productReferralCode: productReferralCode ?? this.productReferralCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        shopId: json["shop_id"],
        orderId: json["order_id"],
        sellerId: json["seller_id"],
        productId: json["product_id"],
        variation: json["variation"],
        price: json["price"],
        vat: json["vat"],
        shippingCost: json["shipping_cost"],
        quantity: json["quantity"],
        paymentStatus: json["payment_status"],
        deliveryStatus: json["delivery_status"],
        shippingType: json["shipping_type"],
        pickupPointId: json["pickup_point_id"],
        productReferralCode: json["product_referral_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "order_id": orderId,
        "seller_id": sellerId,
        "product_id": productId,
        "variation": variation,
        "price": price,
        "vat": vat,
        "shipping_cost": shippingCost,
        "quantity": quantity,
        "payment_status": paymentStatus,
        "delivery_status": deliveryStatus,
        "shipping_type": shippingType,
        "pickup_point_id": pickupPointId,
        "product_referral_code": productReferralCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PaymentDetails {
  PaymentDetails({
    this.tranId,
    this.valId,
    this.amount,
    this.cardType,
    this.storeAmount,
    this.cardNo,
    this.bankTranId,
    this.status,
    this.tranDate,
    this.currency,
    this.cardIssuer,
    this.cardBrand,
    this.cardIssuerCountry,
    this.cardIssuerCountryCode,
    this.storeId,
    this.verifySign,
    this.verifyKey,
    this.verifySignSha2,
    this.currencyType,
    this.currencyAmount,
    this.currencyRate,
    this.baseFair,
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.riskLevel,
    this.riskTitle,
    this.q,
  });

  String tranId;
  String valId;
  String amount;
  String cardType;
  String storeAmount;
  dynamic cardNo;
  String bankTranId;
  String status;
  DateTime tranDate;
  String currency;
  String cardIssuer;
  String cardBrand;
  String cardIssuerCountry;
  String cardIssuerCountryCode;
  String storeId;
  String verifySign;
  String verifyKey;
  String verifySignSha2;
  String currencyType;
  String currencyAmount;
  String currencyRate;
  String baseFair;
  dynamic valueA;
  dynamic valueB;
  dynamic valueC;
  dynamic valueD;
  String riskLevel;
  String riskTitle;
  String q;

  PaymentDetails copyWith({
    String tranId,
    String valId,
    String amount,
    String cardType,
    String storeAmount,
    dynamic cardNo,
    String bankTranId,
    String status,
    DateTime tranDate,
    String currency,
    String cardIssuer,
    String cardBrand,
    String cardIssuerCountry,
    String cardIssuerCountryCode,
    String storeId,
    String verifySign,
    String verifyKey,
    String verifySignSha2,
    String currencyType,
    String currencyAmount,
    String currencyRate,
    String baseFair,
    dynamic valueA,
    dynamic valueB,
    dynamic valueC,
    dynamic valueD,
    String riskLevel,
    String riskTitle,
    String q,
  }) =>
      PaymentDetails(
        tranId: tranId ?? this.tranId,
        valId: valId ?? this.valId,
        amount: amount ?? this.amount,
        cardType: cardType ?? this.cardType,
        storeAmount: storeAmount ?? this.storeAmount,
        cardNo: cardNo ?? this.cardNo,
        bankTranId: bankTranId ?? this.bankTranId,
        status: status ?? this.status,
        tranDate: tranDate ?? this.tranDate,
        currency: currency ?? this.currency,
        cardIssuer: cardIssuer ?? this.cardIssuer,
        cardBrand: cardBrand ?? this.cardBrand,
        cardIssuerCountry: cardIssuerCountry ?? this.cardIssuerCountry,
        cardIssuerCountryCode:
            cardIssuerCountryCode ?? this.cardIssuerCountryCode,
        storeId: storeId ?? this.storeId,
        verifySign: verifySign ?? this.verifySign,
        verifyKey: verifyKey ?? this.verifyKey,
        verifySignSha2: verifySignSha2 ?? this.verifySignSha2,
        currencyType: currencyType ?? this.currencyType,
        currencyAmount: currencyAmount ?? this.currencyAmount,
        currencyRate: currencyRate ?? this.currencyRate,
        baseFair: baseFair ?? this.baseFair,
        valueA: valueA ?? this.valueA,
        valueB: valueB ?? this.valueB,
        valueC: valueC ?? this.valueC,
        valueD: valueD ?? this.valueD,
        riskLevel: riskLevel ?? this.riskLevel,
        riskTitle: riskTitle ?? this.riskTitle,
        q: q ?? this.q,
      );

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        tranId: json["tran_id"],
        valId: json["val_id"],
        amount: json["amount"],
        cardType: json["card_type"],
        storeAmount: json["store_amount"],
        cardNo: json["card_no"],
        bankTranId: json["bank_tran_id"],
        status: json["status"],
        tranDate: DateTime.parse(json["tran_date"]),
        currency: json["currency"],
        cardIssuer: json["card_issuer"],
        cardBrand: json["card_brand"],
        cardIssuerCountry: json["card_issuer_country"],
        cardIssuerCountryCode: json["card_issuer_country_code"],
        storeId: json["store_id"],
        verifySign: json["verify_sign"],
        verifyKey: json["verify_key"],
        verifySignSha2: json["verify_sign_sha2"],
        currencyType: json["currency_type"],
        currencyAmount: json["currency_amount"],
        currencyRate: json["currency_rate"],
        baseFair: json["base_fair"],
        valueA: json["value_a"],
        valueB: json["value_b"],
        valueC: json["value_c"],
        valueD: json["value_d"],
        riskLevel: json["risk_level"],
        riskTitle: json["risk_title"],
        q: json["q"],
      );

  Map<String, dynamic> toJson() => {
        "tran_id": tranId,
        "val_id": valId,
        "amount": amount,
        "card_type": cardType,
        "store_amount": storeAmount,
        "card_no": cardNo,
        "bank_tran_id": bankTranId,
        "status": status,
        "tran_date": tranDate.toIso8601String(),
        "currency": currency,
        "card_issuer": cardIssuer,
        "card_brand": cardBrand,
        "card_issuer_country": cardIssuerCountry,
        "card_issuer_country_code": cardIssuerCountryCode,
        "store_id": storeId,
        "verify_sign": verifySign,
        "verify_key": verifyKey,
        "verify_sign_sha2": verifySignSha2,
        "currency_type": currencyType,
        "currency_amount": currencyAmount,
        "currency_rate": currencyRate,
        "base_fair": baseFair,
        "value_a": valueA,
        "value_b": valueB,
        "value_c": valueC,
        "value_d": valueD,
        "risk_level": riskLevel,
        "risk_title": riskTitle,
        "q": q,
      };
}

class ShippingAddress {
  ShippingAddress({
    this.name,
    this.email,
    this.address,
    this.division,
    this.district,
    this.subdistrict,
    this.postalCode,
    this.mobileNumber,
    this.checkoutType,
  });

  String name;
  String email;
  String address;
  String division;
  String district;
  String subdistrict;
  String postalCode;
  String mobileNumber;
  String checkoutType;

  ShippingAddress copyWith({
    String name,
    String email,
    String address,
    String division,
    String district,
    String subdistrict,
    String postalCode,
    String mobileNumber,
    String checkoutType,
  }) =>
      ShippingAddress(
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        division: division ?? this.division,
        district: district ?? this.district,
        subdistrict: subdistrict ?? this.subdistrict,
        postalCode: postalCode ?? this.postalCode,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        checkoutType: checkoutType ?? this.checkoutType,
      );

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        name: json["name"],
        email: json["email"],
        address: json["address"],
        division: json["division"],
        district: json["district"],
        subdistrict: json["subdistrict"],
        postalCode: json["postal_code"],
        mobileNumber: json["mobile_number"],
        checkoutType: json["checkout_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "address": address,
        "division": division,
        "district": district,
        "subdistrict": subdistrict,
        "postal_code": postalCode,
        "mobile_number": mobileNumber,
        "checkout_type": checkoutType,
      };
}
