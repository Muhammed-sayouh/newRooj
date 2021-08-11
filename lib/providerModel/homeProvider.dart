// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/network/dio.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
    this.id,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.imagePath,
    this.salonCount,
    this.name,
    this.salons,
  });

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;
  String? imagePath;
  int? salonCount;
  String? name;
  List<Salon>? salons;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
        imagePath: json["image_path"],
        salonCount: json["salon_count"],
        name: json["name"],
        salons: List<Salon>.from(json["salons"].map((x) => Salon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "image": image,
        "image_path": imagePath,
        "salon_count": salonCount,
        "name": name,
        "salons": List<dynamic>.from(salons!.map((x) => x.toJson())),
      };
}

class Salon {
  Salon({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.address,
    this.views,
    this.openingTime,
    this.closingTime,
    this.place,
    this.availability,
    this.wallet,
    this.cityId,
    this.categoryId,
    this.clientId,
    this.days,
    this.averageReview,
  });

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? address;
  String? views;
  String? openingTime;
  String? closingTime;
  String? place;
  String? availability;
  String? wallet;
  int? cityId;
  int? categoryId;
  int? clientId;
  List<String>? days;
  // ignore: unnecessary_question_mark
  dynamic? averageReview;

  factory Salon.fromJson(Map<String, dynamic> json) => Salon(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        address: json["address"],
        views: json["views"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        place: json["place"],
        availability: json["availability"],
        wallet: json["wallet"],
        cityId: json["city_id"],
        categoryId: json["category_id"],
        clientId: json["client_id"],
        days: json["days"] == null
            ? []
            : List<String>.from(json["days"].map((x) => x)),
        averageReview: json["average_review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "name": name,
        "address": address,
        "views": views,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "place": place,
        "availability": availability,
        "wallet": wallet,
        "city_id": cityId,
        "category_id": categoryId,
        "client_id": clientId,
        "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
        "average_review": averageReview,
      };
}

class HomeProvider with ChangeNotifier {
  Future<List<Datum>> fetchHome() async {
    try {
      Dio.Response response = await dio().post(
        'home',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
          },
        ),
      );
      print(response.data);

      return homeModelFromJson(response.toString()).data;
    } catch (err) {
      return [];
    }
  }
}
