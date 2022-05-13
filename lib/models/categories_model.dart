import 'dart:convert';

CategoriesModel categoryModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoryModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  List<dynamic>? validationErrors;
  bool? hasError;
  dynamic message;
  List<CategoryModel>? data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        validationErrors:
            List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: List<CategoryModel>.from(
            json["Data"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ValidationErrors": List<dynamic>,
        "HasError": hasError,
        "Message": message,
        "Data": List<dynamic>,
      };
}

class CategoryModel {
  CategoryModel({
    this.title,
    this.image,
    this.id,
  });

  String? title;
  String? image;
  String? id;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        title: json["Title"],
        image: json["Image"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Image": image,
        "Id": id,
      };
}
