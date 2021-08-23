import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/screens/notifications/notifications.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:get/get.dart';

Widget clipperWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                SlideDrawer.of(context)!.toggle();
              },
              child: Icon(
                CupertinoIcons.bars,
                color: Colors.white,
                size: 35,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${'welcome'.tr} ${GetStorageHelper.userName()}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "homeTopic".tr,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Get.to(() => NotificationsScreen(), transition: Transition.zoom);
          },
          child: SizedBox(
            child: Image.asset('assets/images/notification_without_dot.png'),
            width: 30,
            height: 30,
          ),
        ),
      ],
    ),
  );
}

Widget clipperWidgetForpages(BuildContext context, String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white,
            size: 35,
          ),
        ),
        Text(
          name,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            Get.to(() => NotificationsScreen(), transition: Transition.zoom);
          },
          child: SizedBox(
            child: Image.asset('assets/images/notification_without_dot.png'),
            width: 25,
            height: 25,
          ),
        ),
      ],
    ),
  );
}
