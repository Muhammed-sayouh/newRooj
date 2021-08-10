// To parse this JSON data, do
//
//     final offersModel = offersModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/network/dio.dart';

OffersModel offersModelFromJson(String str) =>
    OffersModel.fromJson(json.decode(str));

String offersModelToJson(OffersModel data) => json.encode(data.toJson());

class OffersModel {
  OffersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<DatumOffers> data;

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
        status: json["status"],
        message: json["message"],
        data: List<DatumOffers>.from(
            json["data"].map((x) => DatumOffers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumOffers {
  DatumOffers({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.duration,
    required this.price,
    required this.place,
    required this.details,
    required this.percentage,
    required this.priceInOffer,
    required this.offerStartDate,
    required this.offerEndDate,
    required this.salonId,
    required this.subcategoryId,
    required this.isOffer,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String duration;
  int price;
  String place;
  String details;
  int percentage;
  int priceInOffer;
  DateTime offerStartDate;
  DateTime offerEndDate;
  int salonId;
  int subcategoryId;
  bool isOffer;

  factory DatumOffers.fromJson(Map<String, dynamic> json) => DatumOffers(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        place: json["place"],
        details: json["details"],
        percentage: json["percentage"],
        priceInOffer: json["price_in_offer"],
        offerStartDate: DateTime.parse(json["offer_start_date"]),
        offerEndDate: DateTime.parse(json["offer_end_date"]),
        salonId: json["salon_id"],
        subcategoryId: json["subcategory_id"],
        isOffer: json["is_offer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "duration": duration,
        "price": price,
        "place": place,
        "details": details,
        "percentage": percentage,
        "price_in_offer": priceInOffer,
        "offer_start_date":
            "${offerStartDate.year.toString().padLeft(4, '0')}-${offerStartDate.month.toString().padLeft(2, '0')}-${offerStartDate.day.toString().padLeft(2, '0')}",
        "offer_end_date":
            "${offerEndDate.year.toString().padLeft(4, '0')}-${offerEndDate.month.toString().padLeft(2, '0')}-${offerEndDate.day.toString().padLeft(2, '0')}",
        "salon_id": salonId,
        "subcategory_id": subcategoryId,
        "is_offer": isOffer,
      };
}

class OffersProvider with ChangeNotifier {
  Future<List<DatumOffers>> fetchOffers(int id) async {
    try {
      Dio.Response response = await dio().post(
        'offers-of-category',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "salon_id": 1,
            "category_id": id
          },
        ),
      );
      print(response.data);

      return offersModelFromJson(response.toString()).data;
    } catch (err) {
      return [];
    }
  }
}
