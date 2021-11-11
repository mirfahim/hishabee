// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

Message messageFromRawJson(dynamic json) => Message.fromJson(json);

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
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

  Message copyWith({
    int currentPage,
    List<Datum> data,
    String firstPageUrl,
    int from,
    int lastPage,
    String lastPageUrl,
    dynamic nextPageUrl,
    String path,
    int perPage,
    dynamic prevPageUrl,
    int to,
    int total,
  }) =>
      Message(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Datum {
  Datum({
    this.id,
    this.conversationId,
    this.userId,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int conversationId;
  int userId;
  String message;
  String createdAt;
  String updatedAt;

  Datum copyWith({
    int id,
    int conversationId,
    int userId,
    String message,
    String createdAt,
    String updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        conversationId: conversationId ?? this.conversationId,
        userId: userId ?? this.userId,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        conversationId:
            json["conversation_id"] == null ? null : json["conversation_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        message: json["message"] == null ? null : json["message"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "conversation_id": conversationId == null ? null : conversationId,
        "user_id": userId == null ? null : userId,
        "message": message == null ? null : message,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
