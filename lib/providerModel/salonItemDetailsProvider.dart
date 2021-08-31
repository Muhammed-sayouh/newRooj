// To parse this JSON data, do
//
//     final salonItemDetailsModel = salonItemDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:rooj/network/dio.dart';

// To parse this JSON data, do
//
//     final salonItemDetailsModel = salonItemDetailsModelFromJson(jsonString);

SalonItemDetailsModel salonItemDetailsModelFromJson(String str) =>
    SalonItemDetailsModel.fromJson(json.decode(str));

String salonItemDetailsModelToJson(SalonItemDetailsModel data) =>
    json.encode(data.toJson());

class SalonItemDetailsModel {
  SalonItemDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;

  factory SalonItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      SalonItemDetailsModel(
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
    this.salon,
    required this.serviceInHome,
    required this.servicesInSalon,
    this.isFav,
  });

  Salon? salon;
  List<Service> serviceInHome;
  List<Service> servicesInSalon;
  String? isFav;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        salon: Salon.fromJson(json["salon"]),
        serviceInHome: List<Service>.from(
            json["serviceInHome"].map((x) => Service.fromJson(x))),
        servicesInSalon: List<Service>.from(
            json["servicesInSalon"].map((x) => Service.fromJson(x))),
        isFav: json["is_fav"],
      );

  Map<String, dynamic> toJson() => {
        "salon": salon!.toJson(),
        "serviceInHome":
            List<dynamic>.from(serviceInHome.map((x) => x.toJson())),
        "servicesInSalon":
            List<dynamic>.from(servicesInSalon.map((x) => x.toJson())),
        "is_fav": isFav,
      };
}

class Salon {
  Salon({
    this.id,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    this.address,
    this.views,
    this.openingTime,
    this.closingTime,
    this.place,
    this.availability,
    this.wallet,
    this.cityId,
    this.categoryId,
    this.clientId,
    this.days,
    this.averageReview,
    required this.images,
    required this.workers,
    required this.branches,
  });

  int? id;
  DateTime createdAt;
  DateTime updatedAt;
  String? name;
  String? address;
  int? views;
  String? openingTime;
  String? closingTime;
  String? place;
  String? availability;
  String? wallet;
  int? cityId;
  int? categoryId;
  int? clientId;
  String? days;
  String? averageReview;
  List<Image> images;
  List<Branch> workers;
  List<Branch> branches;

  factory Salon.fromJson(Map<String, dynamic> json) => Salon(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        address: json["address"],
        views: json["views"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        place: json["place"],
        availability: json["availability"],
        wallet: json["wallet"],
        cityId: json["city_id"],
        categoryId: json["category_id"],
        clientId: json["client_id"],
        days: json["days"],
        averageReview: json["average_review"] ?? '0.0',
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        workers:
            List<Branch>.from(json["workers"].map((x) => Branch.fromJson(x))),
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "address": address,
        "views": views,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "place": place,
        "availability": availability,
        "wallet": wallet,
        "city_id": cityId,
        "category_id": categoryId,
        "client_id": clientId,
        "days": days,
        "average_review": averageReview,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "workers": List<dynamic>.from(workers.map((x) => x.toJson())),
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    this.address,
    this.salonId,
    required this.selected,
  });

  int? id;
  DateTime createdAt;
  DateTime updatedAt;
  String? name;
  String? address;
  int? salonId;
  bool selected;
  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        address: json["address"] == null ? null : json["address"],
        salonId: json["salon_id"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "address": address == null ? null : address,
        "salon_id": salonId,
      };
}

class Image {
  Image({
    this.id,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.imageableId,
    this.imageableType,
    this.imagePath,
  });

  int? id;
  DateTime createdAt;
  DateTime updatedAt;
  String? image;
  int? imageableId;
  String? imageableType;
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

class Service {
  Service({
    this.id,
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
  });

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

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        duration: json["duration"] == null ? null : json["duration"],
        price: json["price"],
        place: json["place"],
        details: json["details"],
        percentage: json["percentage"] == null ? null : json["percentage"],
        priceInOffer:
            json["price_in_offer"] == null ? null : json["price_in_offer"],
        offerStartDate: json["offer_start_date"] == null
            ? null
            : DateTime.parse(json["offer_start_date"]),
        offerEndDate: json["offer_end_date"] == null
            ? null
            : DateTime.parse(json["offer_end_date"]),
        salonId: json["salon_id"],
        subcategoryId: json["subcategory_id"],
        isOffer: json["is_offer"],
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

class SalonItemDetailsProvider with ChangeNotifier {
  Future<Data> fetchSalonItemDetails(int id) async {
    try {
      Dio.Response response = await dio().post(
        'salon-details',
        data: Dio.FormData.fromMap(
          {"api_password": "QLJsQZgVWY9hVXSjPP", "salon_id": id},
        ),
      );
      print(response.data);

      return salonItemDetailsModelFromJson(response.toString()).data;
    } catch (err) {
      return Data(
          salon: Salon(
            id: 1,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            name: 'name',
            address: 'address',
            views: 30,
            openingTime: 'openingTime',
            closingTime: 'closingTime',
            place: 'place',
            availability: '0',
            wallet: 'wallet',
            cityId: 0,
            categoryId: 2,
            clientId: 2,
            days: '',
            averageReview: '0',
            images: [],
            workers: [],
            branches: [],
          ),
          isFav: '',
          serviceInHome: [],
          servicesInSalon: []);
    }
  }
}
