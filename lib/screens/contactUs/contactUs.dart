import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/imageForAbout.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/contactUsProvider.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/sizes.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController desc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    bool done = Provider.of<ContactUsProvider>(context, listen: false).done;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      done = await Provider.of<ContactUsProvider>(context, listen: false)
          .contactUs(name.text, phone.text, desc.text);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("This user does not exist".tr, context);
    } finally {
      if (done) {
        customSnackBar(
            title: "ok".tr,
            content:
                "Your message has been sent successfully, the administration will contact you soon"
                    .tr);
        Future.delayed(Duration(seconds: 2))
            .then((value) => Get.offAll(MainPage(index: 3)));
      }
    }
  }

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
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        hint: "namee".tr,
                        obscureText: false,
                        controller: name,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Thisfieldisrequired".tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        hint: "phonee".tr,
                        obscureText: false,
                        controller: phone,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Thisfieldisrequired".tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyBigTextFormField(
                        hint: "message".tr,
                        obscureText: false,
                        controller: desc,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Thisfieldisrequired".tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height(context) * 0.08,
                      ),
                      smallButton(
                          context: context, title: 'send'.tr, onTap: _submit)
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
