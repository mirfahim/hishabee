// To parse this JSON data, do
//
//     final productResponseModel = productResponseModelFromJson(jsonString);

import 'dart:convert';

import 'attribute_response_model.dart';

List<Product> productResponseModelFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
List<Product> productResponseModelFromRawJson(dynamic json) =>
    List<Product>.from((json as List<dynamic>).map((x) => Product.fromJson(x)));

String productResponseModelToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product(
      { this.id,
        this.userId,
        this.subUnit,
        this.unit,
        this.shopId,
        this.productId,
        this.name,
        this.subCategory,
        this.sellingPrice,
        this.costPrice,
        this.wholesalePrice,
        this.wholesaleAmount,
        this.gallery,
        this.warrantyType,
        this.warranty,
        this.stock,
        this.description,
        this.vatApplicable,
        this.barcode,
        this.imageUrl,
        this.productType,
        this.approved,
        this.stockAlert,
        this.createdAt,
        this.updatedAt,
        this.vatPercent,
        this.addedBy,
        this.brandId,
        this.thumbnailImg,
        this.featuredImg,
        this.flashDealImg,
        this.videoProvider,
        this.videoLink,
        this.tags,
        this.choiceOptions,
        this.colors,
        this.todaysDeal,
        this.published,
        this.featured,
        this.discount,
        this.discountType,
        this.shippingType,
        this.shippingCost,
        this.numOfSale,
        this.metaTitle,
        this.metaDescription,
        this.metaImg,
        this.pdf,
        this.slug,
        this.rating,
        this.digital,
        this.fileName,
        this.filePath,
        this.locationId,
        this.pickupInstruction,
        this.version,
        this.uniqueId,
        this.attribute,
      });

  int id;
  int userId;
  SubUnit subUnit;
  int unit;
  int shopId;
  int productId;
  String name;
  int subCategory;
  int sellingPrice;
  int costPrice;
  int wholesalePrice;
  int wholesaleAmount;
  String gallery;
  WarrantyType warrantyType;
  int warranty;
  int stock;
  String description;
  bool vatApplicable;
  String barcode;
  String imageUrl;
  ProductType productType;
  DateTime approved;
  int stockAlert;
  DateTime createdAt;
  DateTime updatedAt;
  double vatPercent;
  AddedBy addedBy;
  dynamic brandId;
  dynamic thumbnailImg;
  dynamic featuredImg;
  dynamic flashDealImg;
  dynamic videoProvider;
  dynamic videoLink;
  dynamic tags;
  dynamic choiceOptions;
  dynamic colors;
  int todaysDeal;
  bool published;
  int featured;
  int discount;
  DiscountType discountType;
  ShippingType shippingType;
  int shippingCost;
  int numOfSale;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic metaImg;
  dynamic pdf;
  String slug;
  int rating;
  int digital;
  dynamic fileName;
  dynamic filePath;
  LocationId locationId;
  dynamic pickupInstruction;
  int version;
  String uniqueId;
  List<Attribute> attribute;

  Product copyWith({
    int id,
    int userId,
    SubUnit subUnit,
    int unit,
    int shopId,
    int productId,
    String name,
    int subCategory,
    int sellingPrice,
    int costPrice,
    int wholesalePrice,
    int wholesaleAmount,
    String gallery,
    WarrantyType warrantyType,
    int warranty,
    int stock,
    String description,
    bool vatApplicable,
    String barcode,
    String imageUrl,
    ProductType productType,
    DateTime approved,
    int stockAlert,
    DateTime createdAt,
    DateTime updatedAt,
    double vatPercent,
    AddedBy addedBy,
    dynamic brandId,
    dynamic thumbnailImg,
    dynamic featuredImg,
    dynamic flashDealImg,
    dynamic videoProvider,
    dynamic videoLink,
    dynamic tags,
    dynamic choiceOptions,
    dynamic colors,
    int todaysDeal,
    bool published,
    int featured,
    int discount,
    DiscountType discountType,
    ShippingType shippingType,
    int shippingCost,
    int numOfSale,
    dynamic metaTitle,
    dynamic metaDescription,
    dynamic metaImg,
    dynamic pdf,
    String slug,
    int rating,
    int digital,
    dynamic fileName,
    dynamic filePath,
    LocationId locationId,
    dynamic pickupInstruction,
    int version,
    String uniqueId,
    List<Attribute> attribute,
  }) =>
      Product(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        subUnit: subUnit ?? this.subUnit,
        unit: unit ?? this.unit,
        shopId: shopId ?? this.shopId,
        productId: productId ?? this.productId,
        name: name ?? this.name,
        subCategory: subCategory ?? this.subCategory,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
        wholesalePrice: wholesalePrice ?? this.wholesalePrice,
        wholesaleAmount: wholesaleAmount ?? this.wholesaleAmount,
        gallery: gallery ?? this.gallery,
        warrantyType: warrantyType ?? this.warrantyType,
        warranty: warranty ?? this.warranty,
        stock: stock ?? this.stock,
        description: description ?? this.description,
        vatApplicable: vatApplicable ?? this.vatApplicable,
        barcode: barcode ?? this.barcode,
        imageUrl: imageUrl ?? this.imageUrl,
        productType: productType ?? this.productType,
        approved: approved ?? this.approved,
        stockAlert: stockAlert ?? this.stockAlert,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        vatPercent: vatPercent ?? this.vatPercent,
        addedBy: addedBy ?? this.addedBy,
        brandId: brandId ?? this.brandId,
        thumbnailImg: thumbnailImg ?? this.thumbnailImg,
        featuredImg: featuredImg ?? this.featuredImg,
        flashDealImg: flashDealImg ?? this.flashDealImg,
        videoProvider: videoProvider ?? this.videoProvider,
        videoLink: videoLink ?? this.videoLink,
        tags: tags ?? this.tags,
        choiceOptions: choiceOptions ?? this.choiceOptions,
        colors: colors ?? this.colors,
        todaysDeal: todaysDeal ?? this.todaysDeal,
        published: published ?? this.published,
        featured: featured ?? this.featured,
        discount: discount ?? this.discount,
        discountType: discountType ?? this.discountType,
        shippingType: shippingType ?? this.shippingType,
        shippingCost: shippingCost ?? this.shippingCost,
        numOfSale: numOfSale ?? this.numOfSale,
        metaTitle: metaTitle ?? this.metaTitle,
        metaDescription: metaDescription ?? this.metaDescription,
        metaImg: metaImg ?? this.metaImg,
        pdf: pdf ?? this.pdf,
        slug: slug ?? this.slug,
        rating: rating ?? this.rating,
        digital: digital ?? this.digital,
        fileName: fileName ?? this.fileName,
        filePath: filePath ?? this.filePath,
        locationId: locationId ?? this.locationId,
        pickupInstruction: pickupInstruction ?? this.pickupInstruction,
        version: version ?? this.version,
        uniqueId: uniqueId ?? this.uniqueId,
        attribute: attribute ?? this.attribute,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    userId: json["user_id"],
    subUnit: json["sub_unit"] == null ? null : subUnitValues.map[json["sub_unit"]],
    unit: json["unit"] == null ? null : json["unit"],
    shopId: json["shop_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    name: json["name"],
    subCategory: json["sub_category"] == null ? null : json["sub_category"],
    sellingPrice: json["selling_price"],
    costPrice: json["cost_price"],
    wholesalePrice: json["wholesale_price"] == null ? null : json["wholesale_price"],
    wholesaleAmount: json["wholesale_amount"] == null ? null : json["wholesale_amount"],
    gallery: json["gallery"] == null ? null : json["gallery"],
    warrantyType: json["warranty_type"] == null ? null : warrantyTypeValues.map[json["warranty_type"]],
    warranty: json["warranty"] == null ? null : json["warranty"],
    stock: json["stock"],
    description: json["description"] == null ? null : json["description"],
    vatApplicable: json["vat_applicable"],
    barcode: json["barcode"] == null ? null : json["barcode"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    productType: productTypeValues.map[json["product_type"]],
    approved: json["approved"] == null ? null : DateTime.parse(json["approved"]),
    stockAlert: json["stock_alert"] == null ? null : json["stock_alert"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    vatPercent: json["vat_percent"].toDouble(),
    addedBy: addedByValues.map[json["added_by"]],
    brandId: json["brand_id"],
    thumbnailImg: json["thumbnail_img"],
    featuredImg: json["featured_img"],
    flashDealImg: json["flash_deal_img"],
    videoProvider: json["video_provider"],
    videoLink: json["video_link"],
    tags: json["tags"],
    choiceOptions: json["choice_options"],
    colors: json["colors"],
    todaysDeal: json["todays_deal"],
    published: json["published"],
    featured: json["featured"],
    discount: json["discount"] == null ? null : json["discount"],
    discountType: json["discount_type"] == null ? null : discountTypeValues.map[json["discount_type"]],
    shippingType: shippingTypeValues.map[json["shipping_type"]],
    shippingCost: json["shipping_cost"] == null ? null : json["shipping_cost"],
    numOfSale: json["num_of_sale"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaImg: json["meta_img"],
    pdf: json["pdf"],
    slug: json["slug"] == null ? null : json["slug"],
    rating: json["rating"],
    digital: json["digital"],
    fileName: json["file_name"],
    filePath: json["file_path"],
    locationId: locationIdValues.map[json["location_id"]],
    pickupInstruction: json["pickup_instruction"],
    version: json["version"],
    uniqueId: json["unique_id"],
    attribute: List<Attribute>.from(json["attribute"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "sub_unit": subUnit == null ? null : subUnitValues.reverse[subUnit],
    "unit": unit == null ? null : unit,
    "shop_id": shopId,
    "product_id": productId == null ? null : productId,
    "name": name,
    "sub_category": subCategory == null ? null : subCategory,
    "selling_price": sellingPrice,
    "cost_price": costPrice,
    "wholesale_price": wholesalePrice == null ? null : wholesalePrice,
    "wholesale_amount": wholesaleAmount == null ? null : wholesaleAmount,
    "gallery": gallery == null ? null : gallery,
    "warranty_type": warrantyType == null ? null : warrantyTypeValues.reverse[warrantyType],
    "warranty": warranty == null ? null : warranty,
    "stock": stock,
    "description": description == null ? null : description,
    "vat_applicable": vatApplicable,
    "barcode": barcode == null ? null : barcode,
    "image_url": imageUrl == null ? null : imageUrl,
    "product_type": productTypeValues.reverse[productType],
    "approved": approved == null ? null : approved.toIso8601String(),
    "stock_alert": stockAlert == null ? null : stockAlert,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "vat_percent": vatPercent,
    "added_by": addedByValues.reverse[addedBy],
    "brand_id": brandId,
    "thumbnail_img": thumbnailImg,
    "featured_img": featuredImg,
    "flash_deal_img": flashDealImg,
    "video_provider": videoProvider,
    "video_link": videoLink,
    "tags": tags,
    "choice_options": choiceOptions,
    "colors": colors,
    "todays_deal": todaysDeal,
    "published": published,
    "featured": featured,
    "discount": discount == null ? null : discount,
    "discount_type": discountType == null ? null : discountTypeValues.reverse[discountType],
    "shipping_type": shippingTypeValues.reverse[shippingType],
    "shipping_cost": shippingCost == null ? null : shippingCost,
    "num_of_sale": numOfSale,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_img": metaImg,
    "pdf": pdf,
    "slug": slug == null ? null : slug,
    "rating": rating,
    "digital": digital,
    "file_name": fileName,
    "file_path": filePath,
    "location_id": locationIdValues.reverse[locationId],
    "pickup_instruction": pickupInstruction,
    "version": version,
    "unique_id": uniqueId,
    "attribute": List<dynamic>.from(attribute.map((x) => x.toJson())),
  };

}
enum AddedBy { ADMIN }

final addedByValues = EnumValues({
  "admin": AddedBy.ADMIN
});
enum DiscountType { PERCENT, AMOUNT, EMPTY, DISCOUNT_TYPE_PERCENT }

final discountTypeValues = EnumValues({
  "AMOUNT": DiscountType.AMOUNT,
  "percent": DiscountType.DISCOUNT_TYPE_PERCENT,
  "%": DiscountType.EMPTY,
  "PERCENT": DiscountType.PERCENT
});

enum LocationId { EMPTY }

final locationIdValues = EnumValues({
  "[]": LocationId.EMPTY
});

enum ProductType { SIMPLE, VARIABLE, PRODUCT_TYPE_SIMPLE }

final productTypeValues = EnumValues({
  "'Simple'": ProductType.PRODUCT_TYPE_SIMPLE,
  "SIMPLE": ProductType.SIMPLE,
  "VARIABLE": ProductType.VARIABLE
});

enum ShippingType { FLAT_RATE }

final shippingTypeValues = EnumValues({
  "flat_rate": ShippingType.FLAT_RATE
});

enum SubUnit { SUB_UNIT_PRICE, SUB_UNIT_2_PRICE_20, SUB_UNIT_PRICE_NULL, SUB_UNIT_10_PRICE_1000, SUB_UNIT_29_PRICE_67, SUB_UNIT_PRICE_50, SUB_UNIT_NULL_PRICE_NULL, EMPTY }

final subUnitValues = EnumValues({
  "": SubUnit.EMPTY,
  "{\"sub_unit\":\"10\",\"price\":\"1000\"}": SubUnit.SUB_UNIT_10_PRICE_1000,
  "{\"sub_unit\":\"29\",\"price\":\"67\"}": SubUnit.SUB_UNIT_29_PRICE_67,
  "[ {\"sub_unit\": 2,\"price\":  20} ]": SubUnit.SUB_UNIT_2_PRICE_20,
  "[{\"sub_unit\":null,\"price\":null}]": SubUnit.SUB_UNIT_NULL_PRICE_NULL,
  "{\"sub_unit\":\"\",\"price\":\"\"}": SubUnit.SUB_UNIT_PRICE,
  "[{\"sub_unit\":\"\",\"price\":\"50\"}]": SubUnit.SUB_UNIT_PRICE_50,
  "[{\"sub_unit\":\"\",\"price\":null}]": SubUnit.SUB_UNIT_PRICE_NULL
});

enum WarrantyType { MONTH, DAY, WARRANTY_TYPE_MONTH, WEEK, YEAR, WARRANTY_TYPE_YEAR, WARRANTY_TYPE_WEEK, EMPTY, WARRANTY_TYPE, PURPLE_YEAR, WARRANTY_TYPE_DAY, PURPLE }

final warrantyTypeValues = EnumValues({
  "DAY": WarrantyType.DAY,
  "বছর": WarrantyType.EMPTY,
  "month": WarrantyType.MONTH,
  "": WarrantyType.PURPLE,
  "Year": WarrantyType.PURPLE_YEAR,
  "সপ্তাহ": WarrantyType.WARRANTY_TYPE,
  "Day": WarrantyType.WARRANTY_TYPE_DAY,
  "MONTH": WarrantyType.WARRANTY_TYPE_MONTH,
  "week": WarrantyType.WARRANTY_TYPE_WEEK,
  "year": WarrantyType.WARRANTY_TYPE_YEAR,
  "WEEK": WarrantyType.WEEK,
  "YEAR": WarrantyType.YEAR
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
