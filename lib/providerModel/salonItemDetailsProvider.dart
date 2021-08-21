// To parse this JSON data, do
//
//     final salonItemDetailsModel = salonItemDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/network/dio.dart';

SalonItemDetailsModel salonItemDetailsModelFromJson(String str) =>
    SalonItemDetailsModel.fromJson(json.decode(str));

String salonItemDetailsModelToJson(SalonItemDetailsModel data) =>
    json.encode(data.toJson());

class SalonItemDetailsModel {
  SalonItemDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;

  factory SalonItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      SalonItemDetailsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.salon,
    required this.isFav,
  });

  Salon salon;
  String isFav;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        salon: Salon.fromJson(json["salon"]),
        isFav: json["is_fav"],
      );

  Map<String, dynamic> toJson() => {
        "salon": salon.toJson(),
        "is_fav": isFav,
      };
}

class Salon {
  Salon(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name,
      required this.address,
      required this.views,
      required this.openingTime,
      required this.closingTime,
      required this.place,
      required this.availability,
      required this.wallet,
      required this.cityId,
      required this.categoryId,
      required this.clientId,
      required this.days,
      required this.averageReview,
      required this.images,
      required this.workers,
      required this.branches,
      required this.selected});

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String address;
  int views;
  String openingTime;
  String closingTime;
  String place;
  String availability;
  String wallet;
  int cityId;
  int categoryId;
  int clientId;
  dynamic days;
  dynamic averageReview;
  List<dynamic> images;
  List<dynamic> workers;
  List<dynamic> branches;
  bool selected;

  factory Salon.fromJson(Map<String, dynamic> json) => Salon(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        address: json["address"] ?? '',
        views: json["views"] ?? 0,
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        place: json["place"] ?? '',
        availability: json["availability"] ?? '',
        wallet: json["wallet"] ?? '0',
        cityId: json["city_id"],
        categoryId: json["category_id"],
        clientId: json["client_id"],
        days: json["days"],
        averageReview: json["average_review"] ?? '0.0',
        images: List<dynamic>.from(json["images"].map((x) => x)),
        workers: List<dynamic>.from(json["workers"].map((x) => x)),
        branches: List<dynamic>.from(json["branches"].map((x) => x)),
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
        "days": days,
        "average_review": averageReview,
        "images": List<dynamic>.from(images.map((x) => x)),
        "workers": List<dynamic>.from(workers.map((x) => x)),
        "branches": List<dynamic>.from(branches.map((x) => x)),
      };
}

class SalonItemDetailsProvider with ChangeNotifier {
  Future<Data> fetchSalonItemDetails(int id) async {
    try {
      Dio.Response response = await dio().post(
        'salon-details',
        data: Dio.FormData.fromMap(
          {"api_password": "QLJsQZgVWY9hVXSjPP", "salon_id": id},
        ),
      );
      print(response.data);

      return salonItemDetailsModelFromJson(response.toString()).data;
    } catch (err) {
      return Data(
          salon: Salon(
              id: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              name: 'name',
              address: 'address',
              views: 30,
              openingTime: 'openingTime',
              closingTime: 'closingTime',
              place: 'place',
              availability: '0',
              wallet: 'wallet',
              cityId: 0,
              categoryId: 2,
              clientId: 2,
              days: 5,
              averageReview: 0,
              images: [],
              workers: [],
              branches: [],
              selected: false),
          isFav: '');
    }
  }
}
