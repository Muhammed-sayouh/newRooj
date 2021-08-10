import 'package:flutter/material.dart';
import 'package:rooj/style/colors.dart';

ThemeData getTheme() {
  return ThemeData(
    fontFamily: 'CairoRegular',
    // ignore: deprecated_member_use

    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: AppColors.mainColor,
          )),
      contentPadding: EdgeInsets.all(13),
      border: new OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          style: BorderStyle.none,
        ),
      ),
      disabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.mainColor.withOpacity(0.5),
          style: BorderStyle.solid,
        ),
      ),
      enabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.mainColor.withOpacity(0.5),
          style: BorderStyle.solid,
        ),
      ),
    ),
  );
}
