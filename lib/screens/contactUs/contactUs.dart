import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/imageForAbout.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/style/sizes.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "ContactUs".tr, inMain: false),
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
                Form(
                  child: Column(
                    children: [
                      MyTextFormField(
                        hint: "namee".tr,
                        obscureText: false,
                        controller: name,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        hint: "phonee".tr,
                        obscureText: false,
                        controller: phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyBigTextFormField(
                        hint: "message".tr,
                        obscureText: false,
                        controller: phone,
                      ),
                      SizedBox(
                        height: height(context) * 0.08,
                      ),
                      smallButton(
                          context: context, title: 'send'.tr, onTap: () {})
                    ],
                  ),
                )
              ],
            ),
          ),
          context: context),
    );
  }
}
