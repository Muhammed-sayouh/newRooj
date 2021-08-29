import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

class ContactUsProvider with ChangeNotifier {
  bool done = false;
  Future<bool> contactUs(
    String name,
    String phone,
    String message,
  ) async {
    try {
      Dio.Response response = await dio().post(
        'contact-us',
        data: Dio.FormData.fromMap({
          "api_password": "QLJsQZgVWY9hVXSjPP",
          "name": name,
          "phone": phone,
          "message": message,
        }),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
            'authorization': 'Bearer ${GetStorageHelper.getToken()}'
          },
        ),
      );

      if (response.statusCode == 200) {
        print('object');
        done = true;
      }
      notifyListeners();
      return done;
    } catch (error) {
      throw (error);
    }
  }
}
