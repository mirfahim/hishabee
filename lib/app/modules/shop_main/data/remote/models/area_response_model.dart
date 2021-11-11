// To parse this JSON data, do
//
//     final areaResponse = areaResponseFromJson(jsonString);

import 'dart:convert';

List<Division> areaResponseFromJson(String str) =>
    List<Division>.from(json.decode(str).map((x) => Division.fromJson(x)));

List<Division> areaResponseFromRawJson(dynamic json) => List<Division>.from(
    (json as List<dynamic>).map((x) => Division.fromJson(x)));

String areaResponseToJson(List<Division> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Division {
  Division({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.districts,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  List<District> districts;

  Division copyWith({
    int id,
    String name,
    DateTime createdAt,
    DateTime updatedAt,
    List<District> districts,
  }) =>
      Division(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        districts: districts ?? this.districts,
      );

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        districts: json["districts"] == null
            ? null
            : List<District>.from(
                json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "districts": districts == null
            ? null
            : List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.id,
    this.name,
    this.divisionId,
    this.createdAt,
    this.updatedAt,
    this.areas,
  });

  int id;
  String name;
  int divisionId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Area> areas;

  District copyWith({
    int id,
    String name,
    int divisionId,
    DateTime createdAt,
    DateTime updatedAt,
    List<Area> areas,
  }) =>
      District(
        id: id ?? this.id,
        name: name ?? this.name,
        divisionId: divisionId ?? this.divisionId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        areas: areas ?? this.areas,
      );

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        divisionId: json["division_id"] == null ? null : json["division_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        areas: json["areas"] == null
            ? null
            : List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "division_id": divisionId == null ? null : divisionId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "areas": areas == null
            ? null
            : List<dynamic>.from(areas.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    this.id,
    this.name,
    this.lat,
    this.lng,
    this.districtId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  double lat;
  double lng;
  int districtId;
  dynamic createdAt;
  dynamic updatedAt;

  Area copyWith({
    int id,
    String name,
    double lat,
    double lng,
    int districtId,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      Area(
        id: id ?? this.id,
        name: name ?? this.name,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        districtId: districtId ?? this.districtId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
        districtId: json["district_id"] == null ? null : json["district_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "district_id": districtId == null ? null : districtId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
