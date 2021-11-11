class Variation {
  Variation({
    this.shopProductId,
    this.name,
    this.sellingPrice,
    this.costPrice,
    this.stock,
    this.variationCriteria,
    this.barcode,
    this.imageUrl,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String shopProductId;
  String name;
  String sellingPrice;
  String costPrice;
  String stock;
  String variationCriteria;
  String barcode;
  dynamic imageUrl;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Variation copyWith({
    String shopProductId,
    String name,
    String sellingPrice,
    String costPrice,
    String stock,
    String variationCriteria,
    String barcode,
    dynamic imageUrl,
    DateTime updatedAt,
    DateTime createdAt,
    int id,
  }) =>
      Variation(
        shopProductId: shopProductId ?? this.shopProductId,
        name: name ?? this.name,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
        stock: stock ?? this.stock,
        variationCriteria: variationCriteria ?? this.variationCriteria,
        barcode: barcode ?? this.barcode,
        imageUrl: imageUrl ?? this.imageUrl,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        shopProductId:
            json["shop_product_id"] == null ? null : json["shop_product_id"],
        name: json["name"] == null ? null : json["name"],
        sellingPrice:
            json["selling_price"] == null ? null : json["selling_price"],
        costPrice: json["cost_price"] == null ? null : json["cost_price"],
        stock: json["stock"] == null ? null : json["stock"],
        variationCriteria: json["variation_criteria"] == null
            ? null
            : json["variation_criteria"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        imageUrl: json["image_url"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "shop_product_id": shopProductId == null ? null : shopProductId,
        "name": name == null ? null : name,
        "selling_price": sellingPrice == null ? null : sellingPrice,
        "cost_price": costPrice == null ? null : costPrice,
        "stock": stock == null ? null : stock,
        "variation_criteria":
            variationCriteria == null ? null : variationCriteria,
        "barcode": barcode == null ? null : barcode,
        "image_url": imageUrl,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
