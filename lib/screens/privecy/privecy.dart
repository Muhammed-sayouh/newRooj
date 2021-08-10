import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/imageForAbout.dart';
import 'package:rooj/style/sizes.dart';

class PrivecyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "praivcy".tr, inMain: false),
      body: stackWidget(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height(context) * 0.03,
                ),
                ImageWidgetForAbout(),
                SizedBox(
                  height: height(context) * 0.06,
                ),
                Container(
                  width: width(context) * 0.86,
                  child: Text(
                    'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.1,
                ),
              ],
            ),
          ),
          context: context),
    );
  }
}
