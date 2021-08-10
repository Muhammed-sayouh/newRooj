// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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
    this.wallet,
    this.imagePath,
    this.certificatePath,
    this.cityName,
  });

  int? wallet;
  String? imagePath;
  String? certificatePath;
  String? cityName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallet: json["wallet"],
        imagePath: json["image_path"],
        certificatePath: json["certificate_path"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "wallet": wallet,
        "image_path": imagePath,
        "certificate_path": certificatePath,
        "city_name": cityName,
      };
}

class WalletProvider with ChangeNotifier {
  Future<Data> fetchWallet() async {
    try {
      Dio.Response response = await dio().post(
        'wallet',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
          },
        ),
        options: Dio.Options(
          headers: {'authorization': 'Bearer ${GetStorageHelper.getToken()}'},
        ),
      );
      print(response.data);

      return walletModelFromJson(response.toString()).data;
    } catch (err) {
      return Data(certificatePath: '', cityName: '', imagePath: '', wallet: 0);
    }
  }
}
