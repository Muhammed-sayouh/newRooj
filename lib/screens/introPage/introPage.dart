import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/screens/mainAuthScreen/mainAuthScreen.dart';
import 'package:rooj/style/sizes.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/intro_bg.png',
              ),
              fit: BoxFit.fill),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: height(context) * 0.5),
          child: Container(
            child: Column(
              children: [
                Text(
                  "intro1".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "intro2".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "intro3".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.12,
                ),
                InkWell(
                  onTap: () => Get.to(
                    () => MainAuthScreen(),
                    transition: Transition.zoom,
                  ),
                  child: SizedBox(
                    width: 50,
                    child: Image.asset(
                      'assets/images/go.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
