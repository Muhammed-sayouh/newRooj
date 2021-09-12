import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/network/dio.dart';

class Auth with ChangeNotifier {
  bool loggedIn = false;
  bool faceBookloggedIn = false;
  bool loggedOut = false;
  bool isRegisteredUser = false;
  bool isRegisteredVendor = false;
  bool correctUserPhone = false;
  bool correctCode = false;
  bool loginfromfacebook = false;
  bool doneEdaitUserProfile = false;
  bool doneEdaitVendorProfile = false;
  int? code;
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

  Future<bool> registerUser(
    String name,
    String phone,
    // String email,
    String password,
  ) async {
    GetStorage storage = GetStorage();

    try {
      Dio.Response response = await dio().post(
        'register',
        data: Dio.FormData.fromMap({
          "api_password": "QLJsQZgVWY9hVXSjPP",
          "phone": phone,
          "type": 0,
          "name": name,
          // "city_id": cityId,
          'email': "",
          "password": password,
          "password_confirmation": password,
          "device_type": Platform.isAndroid ? "android" : "ios",
          "device_token": '5555555555',
        }),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      print(response.data);
      if (response.data['status'] > 201) {
        isRegisteredUser = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        isRegisteredUser = true;
        print('object');
        storage.write(
          'info',
          response.data['data'],
        );
      }
      notifyListeners();
      return isRegisteredUser;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> registerVendor(
      {required String name,
      required String phone,
      // required String email,
      required String password,
      required String id,
      required String insta,
      XFile? image}) async {
    var imageServer;
    if (image != null) {
      imageServer = Dio.MultipartFile.fromFileSync(image.path,
          filename: "${image.path.split('/').last}");
    }
    Map<String, dynamic> map = {
      "api_password": "QLJsQZgVWY9hVXSjPP",
      "phone": phone,
      "type": 1,
      "name": name,
      "password": password,
      // "certificate": imageServer,

      "identity_number": id,
      "email": "",
      "instagram": insta,
      "password_confirmation": password,
      "device_type": Platform.isAndroid ? "android" : "ios",
      "device_token": '5555',
    };
    print(map);
    try {
      Dio.Response response = await dio().post(
        'register',
        data: Dio.FormData.fromMap(map),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      print(response.data);
      if (response.data['status'] > 201) {
        isRegisteredVendor = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        isRegisteredVendor = true;
        print('object');
      }
      notifyListeners();
      return isRegisteredVendor;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> enterPhoneUser(String phone, int type) async {
    try {
      Dio.Response response = await dio().post(
        'register',
        data: Dio.FormData.fromMap({
          "api_password": "QLJsQZgVWY9hVXSjPP",
          "phone": phone,
          "type": type,
        }),
        options: Dio.Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );
      if (response.data['status'] > 201) {
        correctUserPhone = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        print('object');
        correctUserPhone = true;
        print(response.data['data']["register code for test"]);
        code = response.data['data']["register code for test"];
      }
      notifyListeners();
      return correctUserPhone;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> ceckCode(
    String code,
  ) async {
    try {
      Dio.Response response = await dio().post('account-activation',
          data: Dio.FormData.fromMap({
            "api_password": "QLJsQZgVWY9hVXSjPP",
            "register_code": code,
          }),
          options: Dio.Options(headers: {
            "Accept": "application/json",
          }));
      if (response.data['status'] > 201) {
        correctCode = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        print('object');
        correctCode = true;
      }
      notifyListeners();
      return correctCode;
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

  Future<bool> updateVendorProfile(
      String name, String phone, String id, String insta, XFile? image) async {
    var imageServer;
    if (image != null) {
      imageServer = Dio.MultipartFile.fromFileSync(image.path,
          filename: "${image.path.split('/').last}");
    }

    try {
      Map<String, dynamic> map = {
        'name': name,
        'phone': phone,
        "api_password": "QLJsQZgVWY9hVXSjPP",
        "identity_number": id,
        "instagram": insta,
        "certificate": imageServer,
      };
      print(map);
      Dio.Response response = await dio().post(
        'profile',
        data: Dio.FormData.fromMap(map),
        options: Dio.Options(
          headers: {
            'authorization': 'Bearer ${GetStorageHelper.getToken()}',
            "Accept": "application/json",
          },
        ),
      );
      print('${response.data} resppppponse');
      if (response.data['status'] == 400) {
        doneEdaitVendorProfile = false;
        throw HttpExeption('error');
      }
      if (response.data['status'] == 1) {
        doneEdaitVendorProfile = true;
      }
      notifyListeners();
      return doneEdaitVendorProfile;
    } catch (error) {
      throw (error);
    }
  }

  Future<dynamic> getUserProfile() async {
    try {
      Dio.Response response = await dio().post(
        'auth/profile/client',
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

  Future<dynamic> getProviderProfile() async {
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
            'authorization': 'Bearer ${GetStorageHelper.getToken()}',
            "Accept": "application/json",
          },
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
