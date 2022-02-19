// To parse this JSON data, do
//
//     final stockHistory = stockHistoryFromJson(jsonString);

import 'dart:convert';

List<StockHistory> getStockHistoryFromModel(List<Map<String, dynamic>> str) =>
    List<StockHistory>.from(str.map((x) => StockHistory.fromJson(x)));

StockHistory stockHistoryFromJson(dynamic str) => StockHistory.fromJson(str);

String stockHistoryToJson(StockHistory data) => json.encode(data.toJson());

class StockHistory {
  StockHistory({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory StockHistory.fromJson(Map<String, dynamic> json) => StockHistory(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.shopId,
    this.shopProductId,
    this.shopProductVarianceId,
    this.afterStock,
    this.beforeStock,
    this.stockValue,
    this.quantity,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.increase,
    this.bnMessage,
    this.version,
    this.uniqueId,
    this.name,
    this.category,
    this.shopProduct,
  });

  int id;
  int shopId;
  int shopProductId;
  dynamic shopProductVarianceId;
  int afterStock;
  int beforeStock;
  int stockValue;
  int quantity;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  int increase;
  String bnMessage;
  int version;
  dynamic uniqueId;
  String name;
  int category;
  ShopProduct shopProduct;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    shopId: json["shop_id"],
    shopProductId: json["shop_product_id"],
    shopProductVarianceId: json["shop_product_variance_id"],
    afterStock: json["after_stock"],
    beforeStock: json["before_stock"],
    stockValue: json["stock_value"],
    quantity: json["quantity"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    increase: json["increase"],
    bnMessage: json["bn_message"],
    version: json["version"],
    uniqueId: json["unique_id"],
    name: json["name"],
    category: json["category"],
    shopProduct: ShopProduct.fromJson(json["shop_product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "shop_product_id": shopProductId,
    "shop_product_variance_id": shopProductVarianceId,
    "after_stock": afterStock,
    "before_stock": beforeStock,
    "stock_value": stockValue,
    "quantity": quantity,
    "message": message,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "increase": increase,
    "bn_message": bnMessage,
    "version": version,
    "unique_id": uniqueId,
    "name": name,
    "category": category,
    "shop_product": shopProduct.toJson(),
  };
}

class ShopProduct {
  ShopProduct({
    this.id,
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
  });

  int id;
  int userId;
  String subUnit;
  int unit;
  int shopId;
  dynamic productId;
  String name;
  int subCategory;
  int sellingPrice;
  int costPrice;
  int wholesalePrice;
  int wholesaleAmount;
  String gallery;
  String warrantyType;
  int warranty;
  int stock;
  dynamic description;
  bool vatApplicable;
  dynamic barcode;
  dynamic imageUrl;
  String productType;
  dynamic approved;
  dynamic stockAlert;
  DateTime createdAt;
  DateTime updatedAt;
  int vatPercent;
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
  int discount;
  String discountType;
  String shippingType;
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
  String locationId;
  dynamic pickupInstruction;
  int version;
  dynamic uniqueId;

  factory ShopProduct.fromJson(Map<String, dynamic> json) => ShopProduct(
    id: json["id"],
    userId: json["user_id"],
    subUnit: json["sub_unit"],
    unit: json["unit"],
    shopId: json["shop_id"],
    productId: json["product_id"],
    name: json["name"],
    subCategory: json["sub_category"],
    sellingPrice: json["selling_price"],
    costPrice: json["cost_price"],
    wholesalePrice: json["wholesale_price"],
    wholesaleAmount: json["wholesale_amount"],
    gallery: json["gallery"],
    warrantyType: json["warranty_type"],
    warranty: json["warranty"],
    stock: json["stock"],
    description: json["description"],
    vatApplicable: json["vat_applicable"],
    barcode: json["barcode"],
    imageUrl: json["image_url"],
    productType: json["product_type"],
    approved: json["approved"],
    stockAlert: json["stock_alert"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    vatPercent: json["vat_percent"],
    addedBy: json["added_by"],
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
    discount: json["discount"],
    discountType: json["discount_type"],
    shippingType: json["shipping_type"],
    shippingCost: json["shipping_cost"],
    numOfSale: json["num_of_sale"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaImg: json["meta_img"],
    pdf: json["pdf"],
    slug: json["slug"],
    rating: json["rating"],
    digital: json["digital"],
    fileName: json["file_name"],
    filePath: json["file_path"],
    locationId: json["location_id"],
    pickupInstruction: json["pickup_instruction"],
    version: json["version"],
    uniqueId: json["unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "sub_unit": subUnit,
    "unit": unit,
    "shop_id": shopId,
    "product_id": productId,
    "name": name,
    "sub_category": subCategory,
    "selling_price": sellingPrice,
    "cost_price": costPrice,
    "wholesale_price": wholesalePrice,
    "wholesale_amount": wholesaleAmount,
    "gallery": gallery,
    "warranty_type": warrantyType,
    "warranty": warranty,
    "stock": stock,
    "description": description,
    "vat_applicable": vatApplicable,
    "barcode": barcode,
    "image_url": imageUrl,
    "product_type": productType,
    "approved": approved,
    "stock_alert": stockAlert,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "vat_percent": vatPercent,
    "added_by": addedBy,
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
    "discount": discount,
    "discount_type": discountType,
    "shipping_type": shippingType,
    "shipping_cost": shippingCost,
    "num_of_sale": numOfSale,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_img": metaImg,
    "pdf": pdf,
    "slug": slug,
    "rating": rating,
    "digital": digital,
    "file_name": fileName,
    "file_path": filePath,
    "location_id": locationId,
    "pickup_instruction": pickupInstruction,
    "version": version,
    "unique_id": uniqueId,
  };
}

