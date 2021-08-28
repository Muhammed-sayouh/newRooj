import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

showDaialogLoader(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black.withAlpha(0),
        content: Container(
          height: 130,
          width: 50,
          child: Center(
            child: SpinKitWanderingCubes(
              color: AppColors.mainColor,
            ),
          ),
        ),
      );
    },
  );
}

showErrorDaialog(
  String masseage,
  BuildContext context,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppColors.backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          title: Text(
            "خطا",
            style: TextStyle(fontFamily: 'Cairo', color: AppColors.mainColor),
          ),
          content: Text(
            masseage,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Cairo',
            ),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "تم",
                  style: TextStyle(
                      color: AppColors.mainColor, fontFamily: 'Cairo'),
                ))
          ],
        ),
      );
    },
  );
}

Future qrDaialog(String masseage, BuildContext context, String title) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppColors.backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          title: Text(title,
              style:
                  TextStyle(color: AppColors.mainColor, fontFamily: 'Cairo')),
          content: Text(
            masseage,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Cairo',
            ),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "تم",
                  style: TextStyle(
                    color: AppColors.mainColor,
                  ),
                ))
          ],
        ),
      );
    },
  );
}

Widget loadingDialogForPages(BuildContext context) {
  return Container(
      height: height(context) * 0.65,
      width: width(context),
      child: Center(
        child: SpinKitHourGlass(
          color: AppColors.mainColor,
          size: 25,
        ),
      ));
}

Widget loadingDialogForBigPages(BuildContext context) {
  return Container(
      height: height(context),
      width: width(context),
      child: Center(
        child: SpinKitHourGlass(
          color: AppColors.mainColor,
          size: 25,
        ),
      ));
}

Widget loadingDialogForSmallPages(BuildContext context) {
  return Container(
      height: height(context) * 0.58,
      width: width(context),
      child: Center(
        child: SpinKitHourGlass(
          color: AppColors.mainColor,
          size: 25,
        ),
      ));
}

Widget loadingDialogForSmallestPages(BuildContext context) {
  return Container(
      height: height(context) * 0.5,
      width: width(context),
      child: Center(
        child: SpinKitHourGlass(
          color: AppColors.mainColor,
          size: 25,
        ),
      ));
}

customSnackBar({required String title, required String content}) {
  return Get.snackbar(
    title,
    content,
    titleText: Text(
      title,
      // textDirection: TextDirection.rtl,
      style: TextStyle(
        color: AppColors.mainColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: AppColors.backGroundColor,
    messageText: Text(
      content,
      style: TextStyle(
        color: AppColors.mainColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

showAlertLougOut({
  required BuildContext context,
  String title = 'تنبيه',
  required String desc,
  DialogType type = DialogType.WARNING,
  @required okTitle,
  required void Function()? okAction,
  bool showCancelButton = true,
  bool enableDismiss = true,
  required void Function()? cancel,
}) {
  AwesomeDialog(
    context: context,
    dialogType: type,
    animType: AnimType.BOTTOMSLIDE,
    dismissOnTouchOutside: enableDismiss,
    padding: EdgeInsets.only(
      bottom: 10,
      left: 10,
      right: 10,
    ),
    title: 'تنبيه',
    desc: 'هل تريد تسجيل الخروج من التطبيق؟ ',
    // ignore: deprecated_member_use
    btnCancel: RaisedButton(
      color: Colors.black,
      onPressed: cancel,
      child: SizedBox(
        height: height(context) * 0.055,
        child: Center(
          child: Text(
            'الغاء',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    // ignore: deprecated_member_use
    btnOk: SizedBox(
      height: height(context) * 0.055,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: AppColors.mainColor,
        onPressed: okAction,
        child: Center(
          child: Text(
            ' خروج',
            style: TextStyle(color: Colors.white),
            maxLines: 1,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  )..show();
}

showAlert({
  required BuildContext context,
  String title = 'تحذير',
  String? desc,
  DialogType type = DialogType.WARNING,
  @required okTitle,
  bool showCancelButton = true,
  bool enableDismiss = true,
}) {
  AwesomeDialog(
    context: context,
    dialogType: type,
    animType: AnimType.BOTTOMSLIDE,
    dismissOnTouchOutside: enableDismiss,
    padding: EdgeInsets.only(
      bottom: 10,
      left: 10,
      right: 10,
    ),
    title: 'تنبيه',
    desc: 'هل تريد الخروج من التطبيق؟ ',
    // ignore: deprecated_member_use
    btnCancel: RaisedButton(
      color: Colors.black,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'الغاء',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    // ignore: deprecated_member_use
    btnOk: RaisedButton(
      color: AppColors.mainColor,
      onPressed: () {
        SystemNavigator.pop();
      },
      child: Text(
        'خروج',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  )..show();
}
