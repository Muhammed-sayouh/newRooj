// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/network/dio.dart';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
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
      required this.selected});

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  bool selected;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "name": name,
      };
}

class CitiesProvider with ChangeNotifier {
  Future<List<Datum>> fetchCities() async {
    try {
      Dio.Response response = await dio().post(
        'cities',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "lang": Get.locale!.languageCode,
          },
        ),
      );
      print(response.data);

      return citiesModelFromJson(response.toString()).data;
    } catch (err) {
      print('$err errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      return [];
    }
  }
}
