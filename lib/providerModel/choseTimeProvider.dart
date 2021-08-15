// To parse this JSON data, do
//
//     final choseTimeModel = choseTimeModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/network/dio.dart';

ChoseTimeModel choseTimeModelFromJson(String str) =>
    ChoseTimeModel.fromJson(json.decode(str));

String choseTimeModelToJson(ChoseTimeModel data) => json.encode(data.toJson());

class ChoseTimeModel {
  ChoseTimeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;

  factory ChoseTimeModel.fromJson(Map<String, dynamic> json) => ChoseTimeModel(
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
    required this.appointments,
  });

  List<Appointment> appointments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        appointments: List<Appointment>.from(
            json["appointments"].map((x) => Appointment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "appointments": List<dynamic>.from(appointments.map((x) => x.toJson())),
      };
}

class Appointment {
  Appointment({
    required this.id,
    required this.time,
    required this.newTime,
    required this.selected,
  });

  int id;
  String time;
  String newTime;
  bool selected;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        time: json["time"],
        newTime: json["new_time"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "new_time": newTime,
      };
}

class ChoseTimeProvider with ChangeNotifier {
  Future<List<Appointment>> fetchTimes() async {
    try {
      Dio.Response response = await dio().post(
        'appointments',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
          },
        ),
      );
      print(response.data);

      return choseTimeModelFromJson(response.toString()).data.appointments;
    } catch (err) {
      return [];
    }
  }
}
