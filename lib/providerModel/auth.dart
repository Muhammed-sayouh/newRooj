import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

class Auth with ChangeNotifier {
  bool loggedIn = false;
  bool faceBookloggedIn = false;
  bool loggedOut = false;
  bool isRegistered = false;
  bool loginfromfacebook = false;
  bool doneEdaitUserProfile = false;
  String? token;
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  Future<bool> signIn(String phone, String password) async {
    GetStorage storage = GetStorage();
    try {
      Dio.Response response = await dio().post(
        'login',
        data: Dio.FormData.fromMap({
          "api_password": 'QLJsQZgVWY9hVXSjPP',
          "phone": phone,
          "password": password,
          "device_token": password,
          "device_type": Platform.isAndroid ? 'android' : "ios"
        }),
      );
      print(response.data);
      if (response.statusCode == 400) {
        loggedIn = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        loggedIn = true;

        storage.write(
          'info',
          response.data['data'],
        );

        print(storage.read('info')['token']);
      }

      notifyListeners();
      return loggedIn;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> signInFaceBook(String token, String id) async {
    GetStorage storage = GetStorage();
    try {
      Dio.Response response = await dio().get(
        'Auth/login_facebook?token=$token',
      );
      print(response.data);
      print(response.data['data']['api_token']);
      if (response.data['status'] == 400) {
        faceBookloggedIn = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 200) {
        faceBookloggedIn = true;
        loginfromfacebook = true;
        storage.write(
          'info',
          response.data['data'],
        );
      }
      notifyListeners();
      return faceBookloggedIn;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> logout() async {
    GetStorage getStorage = GetStorage();
    try {
      Dio.Response response = await dio().post(
        'Auth/logOut',
        options: Dio.Options(
          headers: {
            'authorization': 'Bearer ${getStorage.read('info')['api_token']}'
          },
        ),
      );
      print(response.data);
      if (response.data['status'] == 400) {
        loggedOut = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 200) {
        loggedOut = true;
        getStorage.erase();
      }
      notifyListeners();
      return loggedOut;
    } catch (error) {
      getStorage.erase();
      throw (error);
    }
  }

  Future<bool> register(
      String name, String phone, String email, String password) async {
    try {
      Dio.Response response = await dio().post(
        'Auth/register_user',
        data: Dio.FormData.fromMap({
          "name": name,
          "password": password,
          'phone': phone,
          'email': email,
        }),
      );
      if (response.data['status'] > 201) {
        isRegistered = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 200) {
        isRegistered = true;
      }
      notifyListeners();
      return isRegistered;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> updateUserProfile(
    String name,
    String phone,
  ) async {
    try {
      Dio.Response response = await dio().post(
        'profile',
        data: Dio.FormData.fromMap(
          {
            'name': name,
            'phone': phone,
            "api_password": "QLJsQZgVWY9hVXSjPP",
          },
        ),
        options: Dio.Options(
          headers: {'authorization': 'Bearer ${GetStorageHelper.getToken()}'},
        ),
      );
      print(response.data);
      if (response.data['status'] == 400) {
        doneEdaitUserProfile = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        doneEdaitUserProfile = true;
      }
      notifyListeners();
      return doneEdaitUserProfile;
    } catch (error) {
      throw (error);
    }
  }

  Future<dynamic> getUserProfile() async {
    try {
      Dio.Response response = await dio().post(
        'profile',
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
      if (response.data['status'] == 400) {
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {}
      notifyListeners();
      return response.data;
    } catch (error) {
      throw (error);
    }
  }
}

class HttpExeption implements Exception {
  final String message;

  HttpExeption(this.message);

  @override
  String toString() {
    return message;
  }
}
    // GetStorage getStorage = GetStorage();
    // var imageServer;
    // if (image != null) {
    //   imageServer = Dio.MultipartFile.fromFileSync(image.path,
    //       filename: "${image.path.split('/').last}");
    // }