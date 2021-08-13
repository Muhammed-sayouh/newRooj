import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/screens/servicesMoreDetails/servicesMoreDetails.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class ItemInfoWidget extends StatelessWidget {
  final String name;
  final String duration;
  final String price;
  final String offer;
  final int index;
  const ItemInfoWidget(
      {Key? key,
      required this.name,
      required this.duration,
      required this.price,
      required this.offer,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(context) * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Container(
              width: width(context) * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.to(
                      () => ServicesMoreDetailsScreen(
                          duration: duration,
                          name: name,
                          price: price,
                          index: index),
                      transition: Transition.zoom,
                    ),
                    child: Text(
                      "more".tr,
                      style: TextStyle(
                          fontSize: 12, decoration: TextDecoration.underline),
                    ),
                  ),
                  Text(
                    duration,
                    style: TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        offer,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemInfoWidgetFoSirv extends StatelessWidget {
  final String name;
  final String duration;
  final String price;
  final String offer;

  const ItemInfoWidgetFoSirv(
      {Key? key,
      required this.name,
      required this.duration,
      required this.price,
      required this.offer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(context) * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Container(
              width: width(context) * 0.55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    duration,
                    style: TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        offer,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
