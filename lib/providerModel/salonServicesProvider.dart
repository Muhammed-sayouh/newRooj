// To parse this JSON data, do
//
//     final salonServiceModel = salonServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/network/dio.dart';

// To parse this JSON data, do
//
//     final salonServiceModel = salonServiceModelFromJson(jsonString);

SalonServiceModel salonServiceModelFromJson(String str) =>
    SalonServiceModel.fromJson(json.decode(str));

String salonServiceModelToJson(SalonServiceModel data) =>
    json.encode(data.toJson());

class SalonServiceModel {
  SalonServiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory SalonServiceModel.fromJson(Map<String, dynamic> json) =>
      SalonServiceModel(
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
  Datum(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.duration,
      this.price,
      this.place,
      this.details,
      this.percentage,
      this.priceInOffer,
      this.offerStartDate,
      this.offerEndDate,
      this.salonId,
      this.subcategoryId,
      this.isOffer,
      required this.addetionalPresons,
      required this.totalPriceOfWorkers,
      required this.selected});

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? duration;
  int? price;
  String? place;
  String? details;
  int? percentage;
  int? priceInOffer;
  DateTime? offerStartDate;
  DateTime? offerEndDate;
  int? salonId;
  int? subcategoryId;
  bool? isOffer;
  int addetionalPresons;
  int totalPriceOfWorkers;
  bool selected;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"] ?? '',
        duration: json["duration"] == null ? '' : json["duration"],
        price: json["price"],
        place: json["place"],
        details: json["details"],
        percentage: json["percentage"] == null ? null : json["percentage"],
        priceInOffer:
            json["price_in_offer"] == null ? 00 : json["price_in_offer"],
        offerStartDate: json["offer_start_date"] == null
            ? null
            : DateTime.parse(json["offer_start_date"]),
        offerEndDate: json["offer_end_date"] == null
            ? null
            : DateTime.parse(json["offer_end_date"]),
        salonId: json["salon_id"],
        subcategoryId: json["subcategory_id"],
        isOffer: json["is_offer"],
        addetionalPresons: 0,
        totalPriceOfWorkers: 0,
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "name": name,
        "duration": duration == null ? null : duration,
        "price": price,
        "place": place,
        "details": details,
        "percentage": percentage == null ? null : percentage,
        "price_in_offer": priceInOffer == null ? null : priceInOffer,
        "offer_start_date": offerStartDate == null
            ? null
            : "${offerStartDate!.year.toString().padLeft(4, '0')}-${offerStartDate!.month.toString().padLeft(2, '0')}-${offerStartDate!.day.toString().padLeft(2, '0')}",
        "offer_end_date": offerEndDate == null
            ? null
            : "${offerEndDate!.year.toString().padLeft(4, '0')}-${offerEndDate!.month.toString().padLeft(2, '0')}-${offerEndDate!.day.toString().padLeft(2, '0')}",
        "salon_id": salonId,
        "subcategory_id": subcategoryId,
        "is_offer": isOffer,
      };
}

class SalonServicesProvider with ChangeNotifier {
  List<Datum> myList = [];
  List<Datum> newList = [];

  void addToList(int id) {
    newList.add(myList.firstWhere((element) => element.id == id));
  }

  void removeFromList(int id) {
    newList.remove(myList.firstWhere((element) => element.id == id));
  }

  double getTotal() {
    double sum = 0;

    for (var i = 0; i < newList.length; i++) {
      sum += newList[i].price!.toInt();
    }
    notifyListeners();
    return sum;
  }

  Future<void> fetchSalonServicesProvider({
    required int salonId,
    required String place,
    required String subcategory,
  }) async {
    Map<String, dynamic> map = {
      "api_password": "QLJsQZgVWY9hVXSjPP",
      "salon_id": salonId.toString(),
      // "lang": Get.locale!.languageCode,
      // "place": place,
      // 'subcategory_id': subcategory
    };

    print(map);
    try {
      Dio.Response response = await dio().post(
        'salon-services',
        data: Dio.FormData.fromMap(
          map,
        ),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      myList = salonServiceModelFromJson(response.toString()).data;
    } catch (err) {
      print(err.toString());
    }
  }
}
