// To parse this JSON data, do
//
//     final subCategoriesModel = subCategoriesModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/network/dio.dart';

SubCategoriesModel subCategoriesModelFromJson(String str) =>
    SubCategoriesModel.fromJson(json.decode(str));

String subCategoriesModelToJson(SubCategoriesModel data) =>
    json.encode(data.toJson());

class SubCategoriesModel {
  SubCategoriesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.image,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
    required this.imagePath,
    required this.name,
  });

  int id;
  String image;
  int categoryId;
  dynamic createdAt;
  dynamic updatedAt;
  String imagePath;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"] ?? '',
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        imagePath: json["image_path"] ?? '',
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image_path": imagePath,
        "name": name,
      };
}

class SubCategoriesProvider with ChangeNotifier {
  Future<List<Datum>> fetchSubCategories() async {
    try {
      Dio.Response response = await dio().post(
        'subcategories',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "lang": Get.locale!.languageCode,
          },
        ),
      );
      print(response.data);

      return subCategoriesModelFromJson(response.toString()).data;
    } catch (err) {
      return [];
    }
  }
}
