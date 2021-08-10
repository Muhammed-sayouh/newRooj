import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/screens/introPage/introPage.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkAuth() {
    String? token = GetStorageHelper.getToken();
    if (token == '') {
      Future.delayed(Duration(seconds: 2)).then(
        (value) => Get.offAll(
          () => IntroScreen(),
          transition: Transition.zoom,
        ),
      );
    } else {
      Future.delayed(Duration(seconds: 2)).then(
        (value) => Get.offAll(
          () => MainPage(index: 3),
          transition: Transition.zoom,
        ),
      );
    }
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        child: Center(
          child: Container(
            width: width(context) * 0.4,
            height: width(context) * 0.4,
            child: Image.asset(
              'assets/images/app_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
