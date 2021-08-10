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
    title: Text(title),
    elevation: 0,
    centerTitle: true,
  );
}
