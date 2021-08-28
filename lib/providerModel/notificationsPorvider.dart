// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
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
    required this.createdAt,
    this.updatedAt,
    this.isRead,
    this.clientId,
    this.title,
  });

  int? id;
  DateTime createdAt;
  DateTime? updatedAt;
  String? isRead;
  int? clientId;
  String? title;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isRead: json["is_read"],
        clientId: json["client_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_read": isRead,
        "client_id": clientId,
        "title": title,
      };
}

class NotificationsProvider with ChangeNotifier {
  Future<List<Datum>> fetchNotifications() async {
    try {
      Dio.Response response = await dio().post(
        'my-notifications',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "lang": Get.locale!.languageCode,
          },
        ),
        options: Dio.Options(
          headers: {'authorization': 'Bearer ${GetStorageHelper.getToken()}'},
        ),
      );
      print(response.data);

      return notificationsModelFromJson(response.toString()).data;
    } catch (err) {
      print('$err errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      return [];
    }
  }
}
