// To parse this JSON data, do
//
//     final reservationsModel = reservationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

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
    this.id,
    this.image,
    this.bookingTime,
    required this.bookingDate,
    this.salonName,
    this.salonId,
    this.total,
  });

  int? id;
  List<dynamic>? image;
  String? bookingTime;
  DateTime bookingDate;
  String? salonName;
  int? salonId;
  String? total;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: List<dynamic>.from(json["image"].map((x) => x)),
        bookingTime: json["booking_time"],
        bookingDate: DateTime.parse(json["booking_date"]),
        salonName: json["salon_name"],
        salonId: json["salon_id"],
        total: json["total"] ?? '0',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": List<dynamic>.from(image!.map((x) => x)),
        "booking_time": bookingTime,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "salon_name": salonName,
        "salon_id": salonId,
        "total": total,
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
      return [];
    }
  }
}
