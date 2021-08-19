import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

import 'auth.dart';

class AddSirvProvider with ChangeNotifier {
  bool done = false;

  Future<bool> signIn({
    required String name,
    required String price,
    List<XFile>? images,
    required String place,
    required String details,
    required String categotyId,
    required String duration,
  }) async {
    List newImage = [];

    images!.forEach((v) {
      newImage.add(Dio.MultipartFile.fromFileSync(v.path,
          filename: "${v.path.split('/').last}"));
    });

    Map<String, dynamic> body = {
      "api_password": "QLJsQZgVWY9hVXSjPP",
      "name": name,
      "price": price,
      "place": place,
      "details": details,
      "subcategory_id": categotyId,
      "duration": duration,
      "salon_id": GetStorageHelper.userid().toString(),
    };
    for (var i = 0; i < newImage.length; i++) {
      body["images[$i]"] = newImage[i];
    }
    print(body);
    try {
      Dio.Response response = await dio().post(
        'make-service',
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
