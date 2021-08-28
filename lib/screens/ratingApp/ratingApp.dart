import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/imageForAbout.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class RatingAppScreen extends StatefulWidget {
  const RatingAppScreen({Key? key}) : super(key: key);

  @override
  _RatingAppScreenState createState() => _RatingAppScreenState();
}

class _RatingAppScreenState extends State<RatingAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "app evaluation".tr, inMain: false),
      body: stackWidget(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height(context) * 0.03,
                ),
                ImageWidgetForRating(),
                SizedBox(
                  height: height(context) * 0.03,
                ),
                Text(
                  'Rate us on'.tr,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.03,
                ),
                SizedBox(
                  width: width(context) * 0.6,
                  height: height(context) * 0.11,
                  child: Image.asset(
                    'assets/images/google-play-badge.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.52,
                  height: height(context) * 0.07,
                  child: Image.asset(
                    'assets/images/app_store.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          context: context),
    );
  }
}
