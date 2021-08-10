// To parse this JSON data, do
//
//     final salonDetailsModel = salonDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/network/dio.dart';

SalonDetailsModel salonDetailsModelFromJson(String str) =>
    SalonDetailsModel.fromJson(json.decode(str));

String salonDetailsModelToJson(SalonDetailsModel data) =>
    json.encode(data.toJson());

class SalonDetailsModel {
  SalonDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory SalonDetailsModel.fromJson(Map<String, dynamic> json) =>
      SalonDetailsModel(
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
    required this.name,
    required this.address,
    required this.cityId,
    required this.place,
    required this.averageReview,
    required this.images,
  });

  int id;
  String name;
  String address;
  int cityId;
  String place;
  String averageReview;
  List<Image> images;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        cityId: json["city_id"],
        place: json["place"],
        averageReview: json["average_review"] ?? '0.0',
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city_id": cityId,
        "place": place,
        "average_review": averageReview,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.imageableId,
    required this.imageableType,
    required this.imagePath,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  int imageableId;
  String imageableType;
  String imagePath;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
        imageableId: json["imageable_id"],
        imageableType: json["imageable_type"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image,
        "imageable_id": imageableId,
        "imageable_type": imageableType,
        "image_path": imagePath,
      };
}

class SalonDetailsProvider with ChangeNotifier {
  Future<List<Datum>> fetchSalonDetails({
    required int salonId,
    required String place,
    required String type,
  }) async {
    Map<String, dynamic> map = {
      "api_password": "QLJsQZgVWY9hVXSjPP",
      "category_id": salonId.toString(),
      "lang": Get.locale!.languageCode,
      "place": place,
      type: '1'
    };

    print(map);
    try {
      Dio.Response response = await dio().post(
        'salon-category',
        data: Dio.FormData.fromMap(
          map,
        ),
      );
      print(response.data);

      return salonDetailsModelFromJson(response.toString()).data;
    } catch (err) {
      return [];
    }
  }
}
