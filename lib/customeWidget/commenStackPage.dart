import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/screens/home/clipper.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

Widget stackWidget({required Widget body, required BuildContext context}) {
  return Stack(
    children: [
      ClipPath(
        clipper: MyCustomClipper(),
        child: Container(
          height: height(context) * 0.13,
          width: width(context),
          color: AppColors.mainColor,
        ),
      ),
      Center(
        child: Container(
          height: height(context) * 0.82,
          width: width(context) * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: body,
        ),
      ),
    ],
  );
}

Widget stackWidgetFullPage(
    {required Widget body, required BuildContext context}) {
  return Stack(
    children: [
      ClipPath(
        clipper: MyCustomClipper(),
        child: Container(
          height: height(context) * 0.13,
          width: width(context),
          color: AppColors.mainColor,
        ),
      ),
      Center(
        child: Container(
          height: height(context) * 0.82,
          width: width(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: body,
        ),
      ),
    ],
  );
}

Widget stackWidgetFullPageSmallappBar(
    {required Widget body, required BuildContext context}) {
  return Stack(
    children: [
      ClipPath(
        clipper: MyCustomClipper(),
        child: Container(
          height: height(context) * 0.13,
          width: width(context),
          color: AppColors.mainColor,
        ),
      ),
      Center(
        child: Container(
          height: height(context),
          width: width(context),
          decoration: BoxDecoration(
            color: AppColors.mainBackGroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: body,
        ),
      ),
    ],
  );
}
