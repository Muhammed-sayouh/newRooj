// To parse this JSON data, do
//
//     final reservationsModel = reservationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

// To parse this JSON data, do
//
//     final reservationsModel = reservationsModelFromJson(jsonString);

ReservationsModel reservationsModelFromJson(String str) =>
    ReservationsModel.fromJson(json.decode(str));

String reservationsModelToJson(ReservationsModel data) =>
    json.encode(data.toJson());

class ReservationsModel {
  ReservationsModel({
    required this.data,
  });

  List<Datum> data;

  factory ReservationsModel.fromJson(Map<String, dynamic> json) =>
      ReservationsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.image,
    required this.bookingTime,
    required this.bookingDate,
    required this.salonName,
    required this.salonId,
    required this.total,
  });

  int id;
  List<Image> image;
  String bookingTime;
  DateTime bookingDate;
  String salonName;
  int salonId;
  int total;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        bookingTime: json["booking_time"],
        bookingDate: DateTime.parse(json["booking_date"]),
        salonName: json["salon_name"],
        salonId: json["salon_id"],
        total: json["total"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "booking_time": bookingTime,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "salon_name": salonName,
        "salon_id": salonId,
        "total": total,
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
  String? imagePath;

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

class ReservationsProvider with ChangeNotifier {
  Future<List<Datum>> fetchReservations(String state) async {
    try {
      Dio.Response response = await dio().post(
        'my-bookings',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "state": state,
          },
        ),
        options: Dio.Options(
          headers: {'authorization': 'Bearer ${GetStorageHelper.getToken()}'},
        ),
      );
      print(response.data);

      return reservationsModelFromJson(response.toString()).data;
    } catch (err) {
      print(err);
      return [];
    }
  }
}
