// To parse this JSON data, do
//
//     final trainingVideoResponseModel = trainingVideoResponseModelFromJson(jsonString);

import 'dart:convert';

List<TrainingVideoResponseModel> trainingVideoResponseModelFromJson(
        String str) =>
    List<TrainingVideoResponseModel>.from(
        json.decode(str).map((x) => TrainingVideoResponseModel.fromJson(x)));
List<TrainingVideoResponseModel> trainingVideoResponseModelFromRawJson(
        dynamic json) =>
    List<TrainingVideoResponseModel>.from((json as List<dynamic>)
        .map((x) => TrainingVideoResponseModel.fromJson(x)));

String trainingVideoResponseModelToJson(
        List<TrainingVideoResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrainingVideoResponseModel {
  TrainingVideoResponseModel({
    this.id,
    this.title,
    this.bnTitle,
    this.videoId,
  });

  int id;
  String title;
  String bnTitle;
  String videoId;

  TrainingVideoResponseModel copyWith({
    int id,
    String title,
    String bnTitle,
    String videoId,
  }) =>
      TrainingVideoResponseModel(
        id: id ?? this.id,
        title: title ?? this.title,
        bnTitle: bnTitle ?? this.bnTitle,
        videoId: videoId ?? this.videoId,
      );

  factory TrainingVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      TrainingVideoResponseModel(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        bnTitle: json["bn_title"] == null ? null : json["bn_title"],
        videoId: json["video_id"] == null ? null : json["video_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "bn_title": bnTitle == null ? null : bnTitle,
        "video_id": videoId == null ? null : videoId,
      };
}
