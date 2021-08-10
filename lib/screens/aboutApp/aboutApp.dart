import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/imageForAbout.dart';
import 'package:rooj/style/sizes.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "aboutApp".tr, inMain: false),
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
                Container(
                  width: width(context) * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/images/snap_chat_circle.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/images/instegram_box_color.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/images/twiter_circle.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          context: context),
    );
  }
}
