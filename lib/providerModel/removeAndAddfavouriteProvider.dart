import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

import 'auth.dart';

class AddAndRemoveFavProvider with ChangeNotifier {
  bool done = false;
  Future<bool> sent(String id) async {
    try {
      Dio.Response response = await dio().post(
        'service-favourite',
        data: Dio.FormData.fromMap(
            {"api_password": 'QLJsQZgVWY9hVXSjPP', "service_id": id}),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
            'authorization': 'Bearer ${GetStorageHelper.getToken()}'
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 400) {
        done = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == "true") {
        done = true;
      }

      notifyListeners();
      return done;
    } catch (error) {
      throw (error);
    }
  }
}
