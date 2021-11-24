List<DigitalPaymentModel> digitalPaymentModelFromJson(dynamic str) =>
    List<DigitalPaymentModel>.from(
        str.map((x) => DigitalPaymentModel.fromJson(x)));

class DigitalPaymentModel {
  DigitalPaymentModel({
    this.id,
    this.code,
    this.type,
    this.paymentStatus,
    this.shopId,
    this.transactionId,
    this.dueId,
    this.customerName,
    this.customerMobile,
    this.customerAddress,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String code;
  String type;
  String paymentStatus;
  int shopId;
  dynamic transactionId;
  int dueId;
  dynamic customerName;
  dynamic customerMobile;
  dynamic customerAddress;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;

  factory DigitalPaymentModel.fromJson(Map<String, dynamic> json) =>
      DigitalPaymentModel(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        paymentStatus: json["payment_status"],
        shopId: json["shop_id"],
        transactionId: json["transaction_id"],
        dueId: json["due_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        customerAddress: json["customer_address"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}