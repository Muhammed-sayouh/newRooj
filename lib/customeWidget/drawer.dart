import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/screens/aboutApp/aboutApp.dart';
import 'package:rooj/screens/changeCity/changeCity.dart';
import 'package:rooj/screens/changeLanguage/changeLanguage.dart';
import 'package:rooj/screens/contactUs/contactUs.dart';
import 'package:rooj/screens/notifications/notifications.dart';
import 'package:rooj/screens/privecy/privecy.dart';
import 'package:rooj/screens/ratingApp/ratingApp.dart';
import 'package:rooj/screens/trems/terms.dart';
import 'package:rooj/screens/wallet/wallet.dart';
import 'package:rooj/spalsh/splashScreen.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:share/share.dart';
import 'package:slide_drawer/slide_drawer.dart';

import 'drawerItem.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool aboutAppTapped = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context),
      color: AppColors.menuBackGround,
      child: Row(
        children: [
          aboutAppTapped
              ? Container(
                  width: width(context) * 0.645,
                  height: height(context) * 0.8,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "aboutApp".tr,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height(context) * 0.2,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => AboutAppScreen(),
                                transition: Transition.zoom);
                          },
                          child: drawerItem(
                              iconData: CupertinoIcons.info_circle,
                              title: "aboutApp".tr),
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ContactUsScreen(),
                                transition: Transition.zoom);
                          },
                          child: drawerItem(
                              iconData: CupertinoIcons.person_2_fill,
                              title: "ContactUs".tr),
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => RatingAppScreen(),
                                transition: Transition.zoom);
                          },
                          child: drawerItem(
                              iconData: CupertinoIcons.star,
                              title: "app evaluation".tr),
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => PrivecyScreen(),
                                transition: Transition.zoom);
                          },
                          child: drawerItem(
                              iconData: CupertinoIcons.lock,
                              title: "praivcy".tr),
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => TermsScreen(),
                                transition: Transition.zoom);
                          },
                          child: drawerItem(
                              iconData: CupertinoIcons.list_dash,
                              title: "Terms".tr),
                        ),
                        SizedBox(
                          height: height(context) * 0.15,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              aboutAppTapped = false;
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.chevron_forward,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: width(context) * 0.645,
                  height: height(context) * 0.8,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.08),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: width(context) * 0.15,
                            child: Image.asset('assets/images/user_off.png'),
                          ),
                          GetStorageHelper.userName() == ''
                              ? Text(
                                  "hello".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  GetStorageHelper.userName().toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                          GetStorageHelper.userType() == ''
                              ? Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : GetStorageHelper.userType() == '0'
                                  ? Text(
                                      "client".tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "provider".tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                          SizedBox(
                            height: height(context) * 0.05,
                          ),
                          InkWell(
                            onTap: () => Get.to(() => WalletScreen(),
                                transition: Transition.zoom),
                            child: drawerItem(
                                iconData: CupertinoIcons.creditcard,
                                title: "Wallet".tr),
                          ),
                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                          InkWell(
                            onTap: () => Get.to(() => NotificationsScreen(),
                                transition: Transition.zoom),
                            child: drawerItem(
                                iconData: CupertinoIcons.bell,
                                title: "notifications".tr),
                          ),
                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                aboutAppTapped = true;
                              });
                            },
                            child: drawerItem(
                                iconData: CupertinoIcons.info_circle,
                                title: "aboutApp".tr),
                          ),
                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                          InkWell(
                            onTap: () => Get.to(
                              () => ChangeCityScreen(),
                              transition: Transition.zoom,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 15,
                                    child: Image.asset(
                                        'assets/images/saudi_flag.png')),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "السعوديه",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => ChangeLanguageScreen(),
                                transition: Transition.zoom,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 21,
                                    child: Image.asset(
                                      'assets/images/lang.png',
                                      fit: BoxFit.fill,
                                    )),
                                SizedBox(
                                  width: 6,
                                ),
                                Get.locale!.languageCode == 'ar'
                                    ? Text(
                                        "العربيه",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "English",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                          InkWell(
                            onTap: () async {
                              Share.share('https://play.google.com/store/');
                            },
                            child: drawerItem(
                                iconData: Icons.share, title: "ShareApp".tr),
                          ),
                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              showAlertLougOut(
                                  context: context,
                                  desc: 'هل تريد تسجيل الخروج',
                                  okTitle: "خروج",
                                  okAction: () {
                                    GetStorage storage = GetStorage();
                                    storage.erase().then(
                                          (value) => Get.offAll(
                                            () => SplashScreen(),
                                            transition: Transition.zoom,
                                          ),
                                        );
                                  },
                                  cancel: () => Get.back());
                            },
                            child: drawerItem(
                                iconData: Icons.logout, title: "SignOut".tr),
                          ),
                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                          IconButton(
                            onPressed: () => SlideDrawer.of(context)!.close(),
                            icon: Icon(
                              CupertinoIcons.xmark,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          Container(
            width: width(context) * 0.07,
            height: height(context) * 0.7,
            color: AppColors.menuBackGround2,
          )
        ],
      ),
    );
  }
}