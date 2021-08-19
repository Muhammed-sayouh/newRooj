import 'package:get_storage/get_storage.dart';

class GetStorageHelper {
  static String? getToken() {
    String? token;
    GetStorage getStorage = GetStorage();

    if (getStorage.read('info') == null) {
      return '';
    }
    token = getStorage.read('info')['token'] ?? '';
    return token;
  }

  static String? userType() {
    GetStorage getStorage = GetStorage();
    String? userType;
    if (getStorage.read('info') == null) {
      return '';
    } else {
      userType = getStorage.read('info')['client']['type'] ?? '';
      return userType;
    }
  }

  static String? userName() {
    GetStorage getStorage = GetStorage();
    String? name;
    if (getStorage.read('info') == null) {
      return '';
    } else {
      name = getStorage.read('info')['client']['name'] ?? '';
      return name;
    }
  }

  static String? userPhone() {
    GetStorage getStorage = GetStorage();
    String? name;
    if (getStorage.read('info') == null) {
      return '';
    } else {
      name = getStorage.read('info')['client']['phone'] ?? '';
      return name;
    }
  }

  static int? userid() {
    GetStorage getStorage = GetStorage();
    int? id;
    if (getStorage.read('info') == null) {
      return 000000;
    } else {
      id = getStorage.read('info')['client']['id'] ?? 000000;
      return id;
    }
  }
}
