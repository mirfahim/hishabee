List<EmiModel> emiModelFromJson(dynamic str) =>
    List<EmiModel>.from(str.map((x) => EmiModel.fromJson(x)));

class EmiModel {
  EmiModel({
    this.id,
    this.code,
    this.paymentStatus,
    this.shopId,
    this.customerName,
    this.customerMobile,
    this.customerAddress,
    this.installment,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.payableAmount,
  });

  int id;
  String code;
  String paymentStatus;
  int shopId;
  String customerName;
  String customerMobile;
  String customerAddress;
  int installment;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  double payableAmount;

  factory EmiModel.fromJson(Map<String, dynamic> json) => EmiModel(
        id: json["id"],
        code: json["code"],
        paymentStatus: json["payment_status"],
        shopId: json["shop_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        customerAddress: json["customer_address"],
        installment: json["installment"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        payableAmount: json["payable_amount"].toDouble(),
      );
}
