import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/notificationsWidget.dart';
import 'package:rooj/providerModel/notificationsPorvider.dart';
import 'package:rooj/style/colors.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool loaderO = false;
  List<Datum> notiItems = [];
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      notiItems =
          await Provider.of<NotificationsProvider>(context, listen: false)
              .fetchNotifications();
      setState(() {
        loaderO = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        loaderO = false;
      });
      print(error);

      throw (error);
    }
  }

  @override
  void initState() {
    futureO();
    super.initState();
  }

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
      body: loaderO
          ? loadingDialogForBigPages(context)
          : stackWidget(
              body: ListView.builder(
                itemCount: notiItems.length,
                itemBuilder: (context, index) {
                  return NotifactionsWidget(
                    title: notiItems[index].title.toString(),
                    subTitle: DateFormat('yyyy-MM-dd HH:mm')
                        .format(notiItems[index].createdAt),
                  );
                },
              ),
              context: context),
    );
  }
}
