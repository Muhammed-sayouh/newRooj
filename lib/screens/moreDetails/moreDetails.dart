import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/providerModel/salonItemDetailsProvider.dart' as Info;

import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class MoreDetailsScreen extends StatefulWidget {
  final String name;
  final List<Info.Branch> branches;

  const MoreDetailsScreen(
      {Key? key, required this.name, required this.branches})
      : super(key: key);
  @override
  _MoreDetailsScreenState createState() => _MoreDetailsScreenState();
}

class _MoreDetailsScreenState extends State<MoreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.mainBackGroundColor,
        width: width(context),
        height: height(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context) * 0.48,
                child: Stack(
                  children: [
                    Container(
                      height: height(context) * 0.38,
                      width: width(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Get.locale!.languageCode == 'en'
                              ? Radius.circular(0)
                              : Radius.circular(200),
                          bottomLeft: Get.locale!.languageCode == 'en'
                              ? Radius.circular(200)
                              : Radius.circular(0),
                        ),
                        child: Image.network(
                          'https://www.almashataspa.com/images/services/beauty-center.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: width(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height(context) * 0.05, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    CupertinoIcons.back,
                                    color: AppColors.mainColor,
                                    size: 35,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Salon details'.tr,
                                  style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    child: Icon(
                                      Icons.share,
                                      color: AppColors.mainColor,
                                    ),
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    child: Image.asset(
                                      'assets/images/notification_without_dot.png',
                                      color: AppColors.mainColor,
                                    ),
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height(context) * 0.28,
                          // right: Get.locale!.languageCode == 'ar'
                          //     ? width(context) * 0.73
                          //     : 0,
                        ),
                        child: SizedBox(
                          width: 65,
                          child: Image.asset(
                            'assets/images/instegram_box.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.04),
                child: Text(
                  "Branches".tr,
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ...widget.branches
                  .map(
                    (e) => Container(
                      width: width(context),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.06,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width(context) * 0.015),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width(context) * 0.67,
                                    child: Text(
                                      e.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Text(
                                    e.address.toString(),
                                    style:
                                        TextStyle(color: AppColors.mainColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.04),
                child: Text(
                  "Times".tr,
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.07),
                child: Row(
                  children: [
                    Text(
                      'السبت',
                    ),
                    SizedBox(
                      width: width(context) * 0.25,
                    ),
                    Row(
                      children: [
                        Text("09:52 ص"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("09:52 ص"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
