import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/notificationsWidget.dart';
import 'package:rooj/style/colors.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
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
        title: Text(
          "notifications".tr,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: stackWidget(
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return NotifactionsWidget(
                title: 'تم تسجيل دخولك بنجاح',
                subTitle: 'قبل 10 ساعات',
              );
            },
          ),
          context: context),
    );
  }
}
