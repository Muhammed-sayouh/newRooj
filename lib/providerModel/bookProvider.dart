import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';
import 'package:rooj/providerModel/salonServicesProvider.dart';
import 'auth.dart';

class BookingProiver with ChangeNotifier {
  bool done = false;
  String? message;
  Future<bool> book({
    required int salonId,
    required String time,
    required String date,
    required int additional,
    required int payMent,
    required List<Datum> services,
    required double lat,
    required double lag,
  }) async {
    try {
      Map<String, dynamic> map = {
        "api_password": 'QLJsQZgVWY9hVXSjPP',
        "salon_id": salonId,
        "booking_time": time.substring(0, 9),
        "booking_date": date.substring(0, 10),
        "additional_persons": additional,
        // "worker_id": '',
        "payment_method_id": payMent,
        "service": services.map((service) => {"id": service.id}).toList(),
        "lat": lat,
        "long": lag,
      };
      print(map);
      Dio.Response response = await dio().post(
        'make-booking',
        data: Dio.FormData.fromMap(map),
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
      if (response.data['status'] == 0) {
        done = false;
        message = response.data['message'];
        notifyListeners();
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
