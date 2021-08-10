import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

Widget smallButton(
    {required BuildContext context,
    required String title,
    required Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: width(context) * 0.28,
      height: height(context) * 0.065,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    ),
  );
}
