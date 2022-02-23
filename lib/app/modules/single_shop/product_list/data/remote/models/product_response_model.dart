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
      {this.id,
      this.shopProductId,
      this.productVarianceId,
      this.name,
      this.sellingPrice,
      this.costPrice,
      this.stock,
      this.version,
      this.wholeSalePrice,
      this.barcode,
      this.imageUrl,
      this.approved,
      this.createdAt,
      this.updatedAt,
      this.variationCriteria,
      this.userId,
      this.shopId,
      this.shopProductVarianceId,
      this.productId,
      this.subCategory,
      this.basePrice,
      this.baseCost,
      this.totalStock,
      this.varianceName,
      this.productName,
      this.description,
      this.vatApplicable,
      this.vatPercent,
      this.attribute,
      this.productType,
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
      this.unit,
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
      this.uniqueID,
      this.subUnit});

  int id;
  int shopProductId;
  dynamic productVarianceId;
  String name;
  num sellingPrice;
  num costPrice;
  int stock;
  int version;
  var wholeSalePrice;
  String barcode;
  String uniqueID;
  String imageUrl;
  DateTime approved;
  DateTime createdAt;
  DateTime updatedAt;
  String variationCriteria;
  int userId;
  int shopId;
  int shopProductVarianceId;
  int productId;
  int subCategory;
  num basePrice;
  num baseCost;
  int totalStock;
  String varianceName;
  String productName;
  String description;
  bool vatApplicable;
  int vatPercent;
  List<Attribute> attribute;
  String productType;
  String addedBy;
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
  dynamic unit;
  dynamic discount;
  dynamic discountType;
  String shippingType;
  var shippingCost;
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
  String subUnit;
  String locationId;
  dynamic pickupInstruction;

  Product copyWith({
    int id,
    int version,
    int shopProductId,
    dynamic productVarianceId,
    String name,
    String subUnit,
    num sellingPrice,
    int costPrice,
    int stock,
    String barcode,
    String imageUrl,
    String uniqueID,
    DateTime approved,
    DateTime createdAt,
    DateTime updatedAt,
    String variationCriteria,
    int userId,
    int shopId,
    int shopProductVarianceId,
    int productId,
    int subCategory,
    int basePrice,
    int baseCost,
    int totalStock,
    String varianceName,
    String productName,
    String description,
    bool vatApplicable,
    var wholeSalePrice,
    int vatPercent,
    List<Attribute> attribute,
    String productType,
    String addedBy,
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
    dynamic unit,
    dynamic discount,
    dynamic discountType,
    String shippingType,
    var shippingCost,
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
    String locationId,
    dynamic pickupInstruction,
  }) =>
      Product(
        id: id ?? this.id,
        shopProductId: shopProductId ?? this.shopProductId,
        productVarianceId: productVarianceId ?? this.productVarianceId,
        name: name ?? this.name,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
        wholeSalePrice: wholeSalePrice ?? this.wholeSalePrice,
        stock: stock ?? this.stock,
        barcode: barcode ?? this.barcode,
        uniqueID: uniqueID ?? this.uniqueID,
        imageUrl: imageUrl ?? this.imageUrl,
        approved: approved ?? this.approved,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        version: version ?? this.version,
        variationCriteria: variationCriteria ?? this.variationCriteria,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        shopProductVarianceId:
            shopProductVarianceId ?? this.shopProductVarianceId,
        productId: productId ?? this.productId,
        subCategory: subCategory ?? this.subCategory,
        basePrice: basePrice ?? this.basePrice,
        baseCost: baseCost ?? this.baseCost,
        totalStock: totalStock ?? this.totalStock,
        varianceName: varianceName ?? this.varianceName,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        vatApplicable: vatApplicable ?? this.vatApplicable,
        vatPercent: vatPercent ?? this.vatPercent,
        attribute: attribute ?? this.attribute,
        productType: productType ?? this.productType,
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
        unit: unit ?? this.unit,
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
        subUnit: subUnit ?? this.subUnit,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        version: json["version"] == null ? null : json["version"],
        shopProductId:
            json["shop_product_id"] == null ? null : json["shop_product_id"],
        productVarianceId: json["product_variance_id"],
        name: json["name"] == null ? null : json["name"],
        sellingPrice:
            json["selling_price"] == null ? null : json["selling_price"],
        costPrice: json["cost_price"] == null ? null : json["cost_price"],
        wholeSalePrice:
            json["wholesale_price"] == null ? null : json["wholesale_price"],
        stock: json["stock"] == null ? null : json["stock"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        // uniqueID: json["unique_id"] == null ? null : json["unique_id"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        approved:
            json["approved"] == null ? null : DateTime.parse(json["approved"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        variationCriteria: json["variation_criteria"] == null
            ? null
            : json["variation_criteria"],
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        shopProductVarianceId: json["shop_product_variance_id"] == null
            ? null
            : json["shop_product_variance_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        basePrice: json["base_price"] == null ? null : json["base_price"],
        baseCost: json["base_cost"] == null ? null : json["base_cost"],
        totalStock: json["total_stock"] == null ? null : json["total_stock"],
        varianceName:
            json["variance_name"] == null ? null : json["variance_name"],
        productName: json["product_name"] == null ? null : json["product_name"],
        description: json["description"] == null ? null : json["description"],
        vatApplicable:
            json["vat_applicable"] == null ? null : json["vat_applicable"],
        vatPercent: json["vat_percent"] == null ? null : json["vat_percent"],
        attribute: json["attribute"] == null
            ? null
            : List<Attribute>.from(
                json["attribute"].map((x) => Attribute.fromJson(x))),
        productType: json["product_type"] == null ? null : json["product_type"],
        addedBy: json["added_by"] == null ? null : json["added_by"],
        brandId: json["brand_id"],
        thumbnailImg: json["thumbnail_img"],
        featuredImg: json["featured_img"],
        flashDealImg: json["flash_deal_img"],
        videoProvider: json["video_provider"],
        videoLink: json["video_link"],
        tags: json["tags"],
        choiceOptions: json["choice_options"],
        colors: json["colors"],
        todaysDeal: json["todays_deal"] == null ? null : json["todays_deal"],
        published: json["published"] == null ? null : json["published"],
        featured: json["featured"] == null ? null : json["featured"],
        unit: json["unit"],
        discount: json["discount"],
        discountType: json["discount_type"],
        shippingType:
            json["shipping_type"] == null ? null : json["shipping_type"],
        shippingCost:
            json["shipping_cost"] == null ? null : json["shipping_cost"],
        numOfSale: json["num_of_sale"] == null ? null : json["num_of_sale"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImg: json["meta_img"],
        pdf: json["pdf"],
        slug: json["slug"] == null ? null : json["slug"],
        rating: json["rating"] == null ? null : json["rating"],
        digital: json["digital"] == null ? null : json["digital"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        pickupInstruction: json["pickup_instruction"],
        subUnit: json["sub_unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "version": version == null ? null : version,
        "shop_product_id": shopProductId == null ? null : shopProductId,
        "product_variance_id": productVarianceId,
        "name": name == null ? null : name,
        "selling_price": sellingPrice == null ? null : sellingPrice,
        "cost_price": costPrice == null ? null : costPrice,
        "wholesale_price": wholeSalePrice == null ? null : wholeSalePrice,
        "stock": stock == null ? null : stock,
        "barcode": barcode == null ? null : barcode,
        // "unique_id": uniqueID == null ? null : uniqueID,
        "image_url": imageUrl == null ? null : imageUrl,
        "approved": approved == null ? null : approved.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "variation_criteria":
            variationCriteria == null ? null : variationCriteria,
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "shop_product_variance_id":
            shopProductVarianceId == null ? null : shopProductVarianceId,
        "product_id": productId == null ? null : productId,
        "sub_category": subCategory == null ? null : subCategory,
        "base_price": basePrice == null ? null : basePrice,
        "base_cost": baseCost == null ? null : baseCost,
        "total_stock": totalStock == null ? null : totalStock,
        "variance_name": varianceName == null ? null : varianceName,
        "product_name": productName == null ? null : productName,
        "description": description == null ? null : description,
        "vat_applicable": vatApplicable == null ? null : vatApplicable,
        "vat_percent": vatPercent == null ? null : vatPercent,
        "attribute": attribute == null
            ? null
            : List<dynamic>.from(attribute.map((x) => x.toJson())),
        "product_type": productType == null ? null : productType,
        "added_by": addedBy == null ? null : addedBy,
        "brand_id": brandId,
        "thumbnail_img": thumbnailImg,
        "featured_img": featuredImg,
        "flash_deal_img": flashDealImg,
        "video_provider": videoProvider,
        "video_link": videoLink,
        "tags": tags,
        "choice_options": choiceOptions,
        "colors": colors,
        "todays_deal": todaysDeal == null ? null : todaysDeal,
        "published": published == null ? null : published,
        "featured": featured == null ? null : featured,
        "unit": unit,
        "discount": discount,
        "discount_type": discountType,
        "shipping_type": shippingType == null ? null : shippingType,
        "shipping_cost": shippingCost == null ? null : shippingCost,
        "num_of_sale": numOfSale == null ? null : numOfSale,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg,
        "pdf": pdf,
        "slug": slug == null ? null : slug,
        "rating": rating == null ? null : rating,
        "digital": digital == null ? null : digital,
        "file_name": fileName,
        "file_path": filePath,
        "location_id": locationId == null ? null : locationId,
        "pickup_instruction": pickupInstruction,
        "sub_unit": subUnit,
      };
}
