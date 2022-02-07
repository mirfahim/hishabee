import 'dart:convert';

List<ProductReportModel> productReportModelFromJson(dynamic str) =>
    List<ProductReportModel>.from(
        str.map((x) => ProductReportModel.fromJson(x)));

///TODO this model is OK

class ProductReportModel {
  ProductReportModel({
    this.id,
    this.userId,
    this.shopId,
    this.productId,
    this.name,
    this.subCategory,
    this.sellingPrice,
    this.costPrice,
    this.stock,
    this.description,
    this.vatApplicable,
    this.barcode,
    this.imageUrl,
    this.productType,
    this.approved,
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
    this.transactionCount,
    this.transactionAmount,
  });

  int id;
  int userId;
  int shopId;
  dynamic productId;
  String name;
  int subCategory;
  int sellingPrice;
  int costPrice;
  int stock;
  String description;
  bool vatApplicable;
  String barcode;
  dynamic imageUrl;
  String productType;
  dynamic approved;
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
  dynamic unit;
  dynamic discount;
  dynamic discountType;
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
  dynamic transactionCount;
  dynamic transactionAmount;

  factory ProductReportModel.fromJson(Map<String, dynamic> json) =>
      ProductReportModel(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        productId: json["product_id"],
        name: json["name"],
        subCategory: json["sub_category"],
        sellingPrice: json["selling_price"],
        costPrice: json["cost_price"],
        stock: json["stock"],
        description: json["description"] == null ? null : json["description"],
        vatApplicable: json["vat_applicable"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        imageUrl: json["image_url"],
        productType: json["product_type"],
        approved: json["approved"],
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
        unit: json["unit"],
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
        transactionCount: json["transaction_count"],
        transactionAmount: json["transaction_amount"],
      );
}
