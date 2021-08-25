import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/providerModel/daysProvider.dart';
import 'package:rooj/screens/addSalon/secondScreen.dart';

class AddSalonProvider with ChangeNotifier {
  bool done = false;

  Future<bool> addSalon({
    required String name,
    required String adress,
    required List<XFile>? images,
    required List<String> workes,
    required List<Branches> branches,
    required List<DayModel> days,
    required String place,
    required String availability,
    required String startDate,
    required String endDate,
    required String categotyId,
  }) async {
    List newImage = [];
    // List newdays = [];

    images!.forEach((v) {
      newImage.add(Dio.MultipartFile.fromFileSync(v.path,
          filename: "${v.path.split('/').last}"));
    });

    // days.forEach((element) {
    //   newImage.add(element.day);
    // });

    Map<String, dynamic> body = {
      "api_password": "QLJsQZgVWY9hVXSjPP",
      "name": name,
      "address": adress,
      "place": place,
      "availability": availability,
      "category_id": categotyId,
      "city_id": '1',
      "workers": workes.map((workes) => {"name": workes}).toList(),
      "branches": branches
          .map(
              (branches) => {"address": branches.adress, "name": branches.name})
          .toList(),
      "days": days.map((e) => e.day).toList(),
      "opening_time": startDate.substring(0, 5),
      "closing_time": endDate.substring(0, 5),
    };
    for (var i = 0; i < newImage.length; i++) {
      body["images[$i]"] = newImage[i];
    }

    print(body);
    try {
      Dio.Response response = await dio().post(
        'make-salon',
        data: Dio.FormData.fromMap(body),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
            'authorization': 'Bearer ${GetStorageHelper.getToken()}'
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 422) {
        print(response.data);
        done = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        done = true;
      }
      notifyListeners();
      return done;
    } catch (error) {
      throw (error);
    }
  }
}
