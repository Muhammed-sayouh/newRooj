import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/screens/moreDetails/moreDetails.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class InfoWidget extends StatelessWidget {
  final String name;
  final String rate;
  final String views;
  final String adress;
  final String from;
  final String to;

  const InfoWidget(
      {Key? key,
      required this.name,
      required this.rate,
      required this.views,
      required this.adress,
      required this.from,
      required this.to})
      : super(key: key);

  String getMyTime(String time) {
    if (int.parse(time.substring(0, 2)) > 12) {
      return '${int.parse(time.substring(0, 2)) - 12}${time.substring(2, 5)} ${'pm'.tr}';
    } else {
      return "${time.substring(0, 5)} ${'am'.tr}";
    }
  }

  bool openOrColsed() {
    if (DateTime.now().hour < int.parse(from.substring(0, 2)) &&
        DateTime.now().hour > int.parse(to.substring(0, 2))) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height(context) * 0.25),
      child: Align(
        alignment: Get.locale!.languageCode == 'ar'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          width: width(context) * 0.8,
          height: height(context) * 0.18,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Get.locale!.languageCode == 'ar'
                  ? Radius.circular(30)
                  : Radius.zero,
              bottomLeft: Get.locale!.languageCode == 'ar'
                  ? Radius.circular(30)
                  : Radius.zero,
              topRight: Get.locale!.languageCode == 'ar'
                  ? Radius.zero
                  : Radius.circular(30),
              bottomRight: Get.locale!.languageCode == 'ar'
                  ? Radius.zero
                  : Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: width(context) * 0.45,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width(context) * 0.4,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: width(context) * 0.1,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  Text(
                                    rate,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye_sharp,
                              color: AppColors.mainColor,
                              size: 20,
                            ),
                            Text(
                              '  $views ${"views".tr}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: width(context) * 0.5,
                      child: Text(
                        adress,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.clock_solid,
                          color: AppColors.mainColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '${getMyTime(from)}    ${getMyTime(to)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width(context) * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Container(
                  width: width(context) * 0.28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: openOrColsed() ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            openOrColsed() ? 'open'.tr : "Closed".tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Get.to(
                            () => MoreDetailsScreen(
                                  name: adress,
                                ),
                            transition: Transition.zoom),
                        child: Text(
                          "Show details".tr,
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
