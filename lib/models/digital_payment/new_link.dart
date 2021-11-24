NewLinkModel newLinkModelFromJson(dynamic str) => NewLinkModel.fromJson(str);

class NewLinkModel {
  NewLinkModel({
    this.code,
    this.message,
    this.url,
  });

  int code;
  String message;
  String url;

  factory NewLinkModel.fromJson(Map<String, dynamic> json) => NewLinkModel(
        code: json["code"],
        message: json["message"],
        url: json["url"],
      );
}
