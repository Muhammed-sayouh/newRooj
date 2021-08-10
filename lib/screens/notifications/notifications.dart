import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/notificationsWidget.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "notifications".tr, inMain: false),
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
