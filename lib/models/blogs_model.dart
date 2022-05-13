import 'dart:convert';

BlogsModel blogModelFromJson(String str) =>
    BlogsModel.fromJson(json.decode(str));

String blogModelToJson(BlogsModel data) => json.encode(data.toJson());

class BlogsModel {
  BlogsModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  List<dynamic>? validationErrors;
  bool? hasError;
  dynamic message;
  List<BlogModel>? data;

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
        validationErrors:
            List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: List<BlogModel>.from(
            json["Data"].map((x) => BlogModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ValidationErrors": List<dynamic>,
        "HasError": hasError,
        "Message": message,
        "Data": List<dynamic>,
      };
}

class BlogModel {
  BlogModel({
    this.title,
    this.content,
    this.image,
    this.categoryId,
    this.isFavorited,
    this.id,
  });

  String? title;
  String? content;
  String? image;
  String? categoryId;
  String? id;
  bool? isFavorited;

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        title: json["Title"],
        content: json["Content"],
        image: json["Image"],
        categoryId: json["CategoryId"],
        id: json["Id"],
        isFavorited: false,
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Content": content,
        "Image": image,
        "CategoryId": categoryId,
        "Id": id,
      };
}
