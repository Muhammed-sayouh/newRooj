// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/network/dio.dart';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  SettingsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
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
    this.twitterLink,
    this.instagramLink,
    this.snapchatLink,
    this.image,
    this.imagePath,
    this.aboutApp,
    this.privacy,
    this.usageTerms,
  });

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? twitterLink;
  String? instagramLink;
  String? snapchatLink;
  String? image;
  String? imagePath;
  String? aboutApp;
  String? privacy;
  String? usageTerms;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        twitterLink: json["twitter_link"],
        instagramLink: json["instagram_link"],
        snapchatLink: json["snapchat_link"],
        image: json["image"],
        imagePath: json["image_path"],
        aboutApp: json["about_app"],
        privacy: json["privacy"],
        usageTerms: json["usage_terms"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "twitter_link": twitterLink,
        "instagram_link": instagramLink,
        "snapchat_link": snapchatLink,
        "image": image,
        "image_path": imagePath,
        "about_app": aboutApp,
        "privacy": privacy,
        "usage_terms": usageTerms,
      };
}

class BasicSittingProvider with ChangeNotifier {
  Future<List<Datum>> fetchBasicSitting() async {
    try {
      Dio.Response response = await dio().post(
        'settings',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "lang": Get.locale!.languageCode,
          },
        ),
      );
      print(response.data);

      return settingsModelFromJson(response.toString()).data;
    } catch (err) {
      print('$err errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      return [];
    }
  }
}
