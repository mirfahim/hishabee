List<EmployeReportModel> employeReportModelFromJson(dynamic str) =>
    List<EmployeReportModel>.from(
        str.map((x) => EmployeReportModel.fromJson(x)));

class EmployeReportModel {
  EmployeReportModel({
    this.id,
    this.userId,
    this.shopId,
    this.name,
    this.position,
    this.mobile,
    this.email,
    this.address,
    this.monthlySalary,
    this.employeeId,
    this.imageSrc,
    this.createdAt,
    this.updatedAt,
    this.transactionCount,
    this.transactionAmount,
  });

  int id;
  int userId;
  int shopId;
  String name;
  String position;
  String mobile;
  dynamic email;
  String address;
  int monthlySalary;
  dynamic employeeId;
  dynamic imageSrc;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic transactionCount;
  dynamic transactionAmount;

  factory EmployeReportModel.fromJson(Map<String, dynamic> json) =>
      EmployeReportModel(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        name: json["name"],
        position: json["position"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        monthlySalary: json["monthly_salary"] == null ? null : json["monthly_salary"],
        employeeId: json["employee_id"],
        imageSrc: json["image_src"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        transactionCount: json["transaction_count"] ?? "0",
        transactionAmount: json["transaction_amount"] ?? "0",
      );
}
