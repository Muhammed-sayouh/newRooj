import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/network/dio.dart';

// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
  dynamic days;
  dynamic averageReview;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"] ?? '',
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
        days: json["days"],
        averageReview: json["average_review"] ?? '0.0',
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
        "availability": place,
        "wallet": wallet,
        "city_id": cityId,
        "category_id": categoryId,
        "client_id": clientId,
        "days": days,
        "average_review": averageReview,
      };
}

class SearchProvider with ChangeNotifier {
  Future<List<Datum>> fetchSearch({
    required String lat,
    required String long,
    required String type,
    required String search,
  }) async {
    Map<String, dynamic> map = {
      "api_password": "QLJsQZgVWY9hVXSjPP",
      "latitude": lat,
      "longitude": long,
      type: search,
    };

    print(map);
    try {
      Dio.Response response = await dio().post(
        'search',
        data: Dio.FormData.fromMap(
          map,
        ),
      );
      print(response.data);

      return searchModelFromJson(response.toString()).data;
    } catch (err) {
      print(err);
      return [];
    }
  }
}
