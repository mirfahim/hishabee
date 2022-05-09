// To parse this JSON data, do
//
//     final transactionItemResponseModel = transactionItemResponseModelFromJson(jsonString);

import 'dart:convert';

List<TransactionItem> transactionModelFromJson(dynamic str) =>
    List<TransactionItem>.from(str.map((x) => TransactionItem.fromJson(x)));
List<TransactionItem> transactionItemResponseModelFromJson(String str) =>
    List<TransactionItem>.from(
        json.decode(str).map((x) => TransactionItem.fromJson(x)));
List<TransactionItem> transactionItemResponseModelFromRawJson(dynamic json) =>
    List<TransactionItem>.from(
        (json as List<dynamic>).map((x) => TransactionItem.fromJson(x)));

String transactionItemResponseModelToJson(List<TransactionItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionItem {
  int id;
  var shopProductUniqueId;
  int shopProductId;
  var shopProductVarianceId;
  int quantity;
  var price;
  var discount;
  String createdAt;
  String updatedAt;
  var vat;
  String status;
  String name;
  int unitPrice;
  var profit;
  int unitVat;
  var unitCost;
  String transactionUniqueId;
  String uniqueId;
  int version;
  int transactionId;
  int shopId;
  String imageSrc;
  int subCategory;
  ShopProduct shopProduct;

  TransactionItem(
      {this.id,
      this.shopProductUniqueId,
      this.shopProductId,
      this.shopProductVarianceId,
      this.quantity,
      this.price,
      this.discount,
      this.createdAt,
      this.updatedAt,
      this.vat,
      this.status,
      this.name,
      this.unitPrice,
      this.profit,
      this.unitVat,
      this.unitCost,
      this.transactionUniqueId,
      this.uniqueId,
      this.version,
      this.transactionId,
      this.shopId,
      this.imageSrc,
      this.subCategory,
      this.shopProduct});

  TransactionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopProductUniqueId = json['shop_product_unique_id'];
    shopProductId = json['shop_product_id'];
    shopProductVarianceId = json['shop_product_variance_id'];
    quantity = json['quantity'];
    price = json['price'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vat = json['vat'];
    status = json['status'];
    name = json['name'];
    unitPrice = json['unit_price'];
    profit = json['profit'];
    unitVat = json['unit_vat'];
    unitCost = json['unit_cost'];
    transactionUniqueId = json['transaction_unique_id'];
    uniqueId = json['unique_id'];
    version = json['version'];
    transactionId = json['transaction_id'];
    shopId = json['shop_id'];
    imageSrc = json['image_src'];
    subCategory = json['sub_category'];
    shopProduct = json['shop_product'] != null
        ? new ShopProduct.fromJson(json['shop_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_product_unique_id'] = this.shopProductUniqueId;
    data['shop_product_id'] = this.shopProductId;
    data['shop_product_variance_id'] = this.shopProductVarianceId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vat'] = this.vat;
    data['status'] = this.status;
    data['name'] = this.name;
    data['unit_price'] = this.unitPrice;
    data['profit'] = this.profit;
    data['unit_vat'] = this.unitVat;
    data['unit_cost'] = this.unitCost;
    data['transaction_unique_id'] = this.transactionUniqueId;
    data['unique_id'] = this.uniqueId;
    data['version'] = this.version;
    data['transaction_id'] = this.transactionId;
    data['shop_id'] = this.shopId;
    data['image_src'] = this.imageSrc;
    data['sub_category'] = this.subCategory;
    if (this.shopProduct != null) {
      data['shop_product'] = this.shopProduct.toJson();
    }
    return data;
  }
}

class ShopProduct {
  int id;
  int userId;
  String subUnit;
  int unit;
  int shopId;
  var productId;
  String name;
  int subCategory;
  int sellingPrice;
  int costPrice;
  var wholesalePrice;
  var wholesaleAmount;
  String gallery;
  String warrantyType;
  int warranty;
  int stock;
  var description;
  bool vatApplicable;
  var barcode;
  var imageUrl;
  String productType;
  var approved;
  var stockAlert;
  String createdAt;
  String updatedAt;
  var vatPercent;
  String addedBy;
  var brandId;
  var thumbnailImg;
  var featuredImg;
  var flashDealImg;
  var videoProvider;
  var videoLink;
  var tags;
  var choiceOptions;
  var colors;
  int todaysDeal;
  bool published;
  int featured;
  var discount;
  var discountType;
  String shippingType;
  int shippingCost;
  int numOfSale;
  var metaTitle;
  var metaDescription;
  var metaImg;
  var pdf;
  String slug;
  int rating;
  int digital;
  var fileName;
  var filePath;
  String locationId;
  var pickupInstruction;
  int version;
  String uniqueId;

  ShopProduct(
      {this.id,
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
      this.uniqueId});

  ShopProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subUnit = json['sub_unit'];
    unit = json['unit'];
    shopId = json['shop_id'];
    productId = json['product_id'];
    name = json['name'];
    subCategory = json['sub_category'];
    sellingPrice = json['selling_price'];
    costPrice = json['cost_price'];
    wholesalePrice = json['wholesale_price'];
    wholesaleAmount = json['wholesale_amount'];
    gallery = json['gallery'];
    warrantyType = json['warranty_type'];
    warranty = json['warranty'];
    stock = json['stock'];
    description = json['description'];
    vatApplicable = json['vat_applicable'];
    barcode = json['barcode'];
    imageUrl = json['image_url'];
    productType = json['product_type'];
    approved = json['approved'];
    stockAlert = json['stock_alert'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vatPercent = json['vat_percent'];
    addedBy = json['added_by'];
    brandId = json['brand_id'];
    thumbnailImg = json['thumbnail_img'];
    featuredImg = json['featured_img'];
    flashDealImg = json['flash_deal_img'];
    videoProvider = json['video_provider'];
    videoLink = json['video_link'];
    tags = json['tags'];
    choiceOptions = json['choice_options'];
    colors = json['colors'];
    todaysDeal = json['todays_deal'];
    published = json['published'];
    featured = json['featured'];
    discount = json['discount'];
    discountType = json['discount_type'];
    shippingType = json['shipping_type'];
    shippingCost = json['shipping_cost'];
    numOfSale = json['num_of_sale'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImg = json['meta_img'];
    pdf = json['pdf'];
    slug = json['slug'];
    rating = json['rating'];
    digital = json['digital'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    locationId = json['location_id'];
    pickupInstruction = json['pickup_instruction'];
    version = json['version'];
    uniqueId = json['unique_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sub_unit'] = this.subUnit;
    data['unit'] = this.unit;
    data['shop_id'] = this.shopId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['sub_category'] = this.subCategory;
    data['selling_price'] = this.sellingPrice;
    data['cost_price'] = this.costPrice;
    data['wholesale_price'] = this.wholesalePrice;
    data['wholesale_amount'] = this.wholesaleAmount;
    data['gallery'] = this.gallery;
    data['warranty_type'] = this.warrantyType;
    data['warranty'] = this.warranty;
    data['stock'] = this.stock;
    data['description'] = this.description;
    data['vat_applicable'] = this.vatApplicable;
    data['barcode'] = this.barcode;
    data['image_url'] = this.imageUrl;
    data['product_type'] = this.productType;
    data['approved'] = this.approved;
    data['stock_alert'] = this.stockAlert;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vat_percent'] = this.vatPercent;
    data['added_by'] = this.addedBy;
    data['brand_id'] = this.brandId;
    data['thumbnail_img'] = this.thumbnailImg;
    data['featured_img'] = this.featuredImg;
    data['flash_deal_img'] = this.flashDealImg;
    data['video_provider'] = this.videoProvider;
    data['video_link'] = this.videoLink;
    data['tags'] = this.tags;
    data['choice_options'] = this.choiceOptions;
    data['colors'] = this.colors;
    data['todays_deal'] = this.todaysDeal;
    data['published'] = this.published;
    data['featured'] = this.featured;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['shipping_type'] = this.shippingType;
    data['shipping_cost'] = this.shippingCost;
    data['num_of_sale'] = this.numOfSale;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_img'] = this.metaImg;
    data['pdf'] = this.pdf;
    data['slug'] = this.slug;
    data['rating'] = this.rating;
    data['digital'] = this.digital;
    data['file_name'] = this.fileName;
    data['file_path'] = this.filePath;
    data['location_id'] = this.locationId;
    data['pickup_instruction'] = this.pickupInstruction;
    data['version'] = this.version;
    data['unique_id'] = this.uniqueId;
    return data;
  }
}
