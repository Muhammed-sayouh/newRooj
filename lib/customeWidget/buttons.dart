import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

Widget saveButton({required final String title, required final String image}) {
  return Container(
    // height: 100,
    width: 150,
    decoration: BoxDecoration(
      color: AppColors.mainColor,
      borderRadius: BorderRadius.all(
        const Radius.circular(50.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0),
          spreadRadius: 10,
          blurRadius: 3,
          offset: Offset(4, 10), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          width: 40,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        RotatedBox(
          quarterTurns: Get.locale!.languageCode == 'ar' ? 0 : 90,
          child: Container(
            margin: EdgeInsets.all(5),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(image)),
            ),
          ),
        )
      ],
    ),
  );
}

Widget saveButtonBig(
    {required final String title,
    required final String image,
    required BuildContext context}) {
  return Container(
    // height: 100,
    width: width(context) * 0.5,
    decoration: BoxDecoration(
      color: AppColors.mainColor,
      borderRadius: BorderRadius.all(
        const Radius.circular(50.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0),
          spreadRadius: 10,
          blurRadius: 3,
          offset: Offset(4, 10), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          width: 40,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        RotatedBox(
          quarterTurns: Get.locale!.languageCode == 'ar' ? 0 : 90,
          child: Container(
            margin: EdgeInsets.all(5),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(image)),
            ),
          ),
        )
      ],
    ),
  );
}
