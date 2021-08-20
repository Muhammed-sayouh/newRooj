// To parse this JSON data, do
//
//     final reservationsDetailsModel = reservationsDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

ReservationsDetailsModel reservationsDetailsModelFromJson(String str) =>
    ReservationsDetailsModel.fromJson(json.decode(str));

String reservationsDetailsModelToJson(ReservationsDetailsModel data) =>
    json.encode(data.toJson());

class ReservationsDetailsModel {
  ReservationsDetailsModel({
    required this.data,
  });

  Data data;

  factory ReservationsDetailsModel.fromJson(Map<String, dynamic> json) =>
      ReservationsDetailsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.services,
    required this.image,
    required this.bookingTime,
    required this.bookingDate,
    required this.salonName,
    required this.salonId,
    required this.total,
    required this.paymentMethodId,
  });

  int id;
  List<Service> services;
  List<Image> image;
  String bookingTime;
  DateTime bookingDate;
  String salonName;
  int salonId;
  int total;
  int paymentMethodId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        bookingTime: json["booking_time"],
        bookingDate: DateTime.parse(json["booking_date"]),
        salonName: json["salon_name"],
        salonId: json["salon_id"],
        total: json["total"],
        paymentMethodId: json["payment_method_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "booking_time": bookingTime,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "salon_name": salonName,
        "salon_id": salonId,
        "total": total,
        "payment_method_id": paymentMethodId,
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

class Service {
  Service({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.duration,
    required this.price,
    required this.place,
    required this.details,
    this.percentage,
    this.priceInOffer,
    this.offerStartDate,
    this.offerEndDate,
    required this.salonId,
    required this.subcategoryId,
    required this.isOffer,
    required this.pivot,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  dynamic duration;
  int price;
  String place;
  String details;
  dynamic percentage;
  dynamic priceInOffer;
  dynamic offerStartDate;
  dynamic offerEndDate;
  int salonId;
  int subcategoryId;
  bool isOffer;
  Pivot pivot;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
        offerStartDate: json["offer_start_date"],
        offerEndDate: json["offer_end_date"],
        salonId: json["salon_id"],
        subcategoryId: json["subcategory_id"],
        isOffer: json["is_offer"],
        pivot: Pivot.fromJson(json["pivot"]),
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
        "offer_start_date": offerStartDate,
        "offer_end_date": offerEndDate,
        "salon_id": salonId,
        "subcategory_id": subcategoryId,
        "is_offer": isOffer,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.bookingId,
    required this.serviceId,
  });

  int bookingId;
  int serviceId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        bookingId: json["booking_id"],
        serviceId: json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "service_id": serviceId,
      };
}

class ReservationsDetialsProvider with ChangeNotifier {
  Data? data;
  Future<void> fetchReservations(String id) async {
    try {
      Dio.Response response = await dio().post(
        'booking-details',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "booking_id": id,
          },
        ),
        options: Dio.Options(
          headers: {
            'authorization': 'Bearer ${GetStorageHelper.getToken()}',
            "Accept": "application/json",
          },
        ),
      );
      print(response.data);

      data = reservationsDetailsModelFromJson(response.toString()).data;
    } catch (err) {
      print(err);
      print(err);
    }
  }
}
