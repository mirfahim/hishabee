import 'dart:convert';

List<UnitList> getUnitFromModel(dynamic str) =>
    List<UnitList>.from(str.map((x) => UnitList.fromJson(x)));

UnitList getAllUnitModelFromJson(Map<String, dynamic> json) =>
    UnitList.fromJson(json);

List<UnitList> getAllUnitFromJson(String str) =>
    List<UnitList>.from(json.decode(str).map((x) => UnitList.fromJson(x)));

String getAllUnitToJson(List<UnitList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnitList {
  int id;
  String name;
  String bnName;
  String type;
  int userId;
  String createdAt;
  String updatedAt;

  UnitList(
      {this.id,
      this.name,
      this.bnName,
      this.type,
      this.userId,
      this.createdAt,
      this.updatedAt});

  UnitList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bnName = json['bn_name'];
    type = json['type'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bn_name'] = this.bnName;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
