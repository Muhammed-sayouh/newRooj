// To parse this JSON data, do
//
//     final vendorProfileModel = vendorProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

// To parse this JSON data, do
//
//     final vendorProfileModel = vendorProfileModelFromJson(jsonString);

import 'dart:convert';

VendorProfileModel vendorProfileModelFromJson(String str) =>
    VendorProfileModel.fromJson(json.decode(str));

String vendorProfileModelToJson(VendorProfileModel data) =>
    json.encode(data.toJson());

class VendorProfileModel {
  VendorProfileModel({
    required this.provider,
  });

  Provider provider;

  factory VendorProfileModel.fromJson(Map<String, dynamic> json) =>
      VendorProfileModel(
        provider: Provider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider.toJson(),
      };
}

class Provider {
  Provider({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.identityNumber,
    required this.instagram,
    required this.salon,
  });

  int id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? identityNumber;
  String? instagram;
  List<Salon> salon;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        identityNumber: json["identity_number"],
        instagram: json["instagram"],
        salon: List<Salon>.from(json["salon"].map((x) => Salon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "identity_number": identityNumber,
        "instagram": instagram,
        "salon": List<dynamic>.from(salon.map((x) => x.toJson())),
      };
}

class Salon {
  Salon({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.image,
    required this.services,
    required this.offers,
  });

  int id;
  String name;
  String address;
  String city;
  List<Image> image;
  List<Service> services;
  List<Offer> offers;

  factory Salon.fromJson(Map<String, dynamic> json) => Salon(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
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

class Offer {
  Offer({
    required this.id,
    required this.salonId,
    required this.salonName,
    required this.salonAddress,
    required this.image,
    required this.name,
    required this.percentage,
  });

  int id;
  int salonId;
  String salonName;
  String salonAddress;
  List<Image> image;
  String name;
  int percentage;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        salonId: json["salon_id"],
        salonName: json["salon_name"],
        salonAddress: json["salon_address"],
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        name: json["name"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "salon_id": salonId,
        "salon_name": salonName,
        "salon_address": salonAddress,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "name": name,
        "percentage": percentage,
      };
}

class Service {
  Service({
    required this.id,
    required this.salonId,
    required this.image,
    required this.name,
  });

  int id;
  int salonId;
  List<Image> image;
  String name;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        salonId: json["salon_id"],
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "salon_id": salonId,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "name": name,
      };
}

class GetProviderProfile with ChangeNotifier {
  Provider? provider;
  Future<void> fetchProvider() async {
    try {
      Dio.Response response = await dio().post(
        '/auth/profile/provider',
        data: Dio.FormData.fromMap(
          {
            "api_password": "QLJsQZgVWY9hVXSjPP",
          },
        ),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
            'authorization': 'Bearer ${GetStorageHelper.getToken()}'
          },
        ),
      );
      print(response.data);

      provider = vendorProfileModelFromJson(response.toString()).provider;
    } catch (err) {}
  }
}
