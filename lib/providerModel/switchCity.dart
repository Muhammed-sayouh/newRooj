import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

class SwitchCityProvider with ChangeNotifier {
  bool done = false;
  Future<bool> switchCity(
    String cityId,
  ) async {
    try {
      Dio.Response response = await dio().post('switch-city',
          data: Dio.FormData.fromMap({
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "city_id": cityId,
          }),
          options: Dio.Options(headers: {
            "Accept": "application/json",
            'authorization': 'Bearer ${GetStorageHelper.getToken()}'
          }));

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
