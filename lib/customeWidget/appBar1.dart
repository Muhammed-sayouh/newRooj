import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/style/colors.dart';

PreferredSizeWidget myAppBar({required String title, required bool inMain}) {
  return AppBar(
    leading: inMain
        ? SizedBox()
        : InkWell(
            onTap: () => Get.back(),
            child: Get.locale!.languageCode == 'ar'
                ? Icon(
                    CupertinoIcons.chevron_forward,
                    color: Colors.white,
                  )
                : Icon(
                    CupertinoIcons.chevron_back,
                    color: Colors.white,
                  ),
          ),
    backgroundColor: AppColors.mainColor,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.bell,
          color: Colors.white,
        ),
      )
    ],
    title: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    elevation: 0,
  );
}

PreferredSizeWidget myAppBarRservationsDetails(
    {required String title, required bool inMain}) {
  return AppBar(
    leading: inMain
        ? SizedBox()
        : InkWell(
            onTap: () => Get.back(),
            child: Get.locale!.languageCode == 'ar'
                ? Icon(
                    CupertinoIcons.chevron_forward,
                    color: Colors.white,
                  )
                : Icon(
                    CupertinoIcons.chevron_back,
                    color: Colors.white,
                  ),
          ),
    backgroundColor: AppColors.mainColor,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.location,
          color: Colors.white,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.xmark_circle_fill,
          color: Colors.white,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.calendar,
          color: Colors.white,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.pen,
          color: Colors.white,
        ),
      ),
    ],
    title: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    elevation: 0,
    centerTitle: true,
  );
}
