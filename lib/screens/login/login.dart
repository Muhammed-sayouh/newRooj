import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/bkAuth.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';
import 'package:rooj/style/sizes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> _submit() async {
    bool auth = Provider.of<Auth>(context, listen: false).loggedIn;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      auth = await Provider.of<Auth>(context, listen: false)
          .signIn(phone.text, password.text);
    } on HttpExeption catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("This user does not exist".tr, context);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("This user does not exist".tr, context);
    } finally {
      if (auth) {
        Get.offAll(MainPage(index: 3));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MainAuthImage(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "login".tr,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyTextFormFieldWithImageAndPerfix(
                              controller: phone,
                              hint: "phonee".tr,
                              image: 'assets/images/smart_phone_line.png',
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter the phone number".tr;
                                } else if (val.length > 9) {
                                  return 'Please enter a valid phone number'.tr;
                                } else {
                                  return null;
                                }
                              },
                              suffix: '966+',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MyTextFormFieldWithImage(
                              obscureText: true,
                              controller: password,
                              hint: "password".tr,
                              image: 'assets/images/lock_line.png',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter the password'.tr;
                                } else if (val.length < 8) {
                                  return 'The password must be at least 8 letters or numbers'
                                      .tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 8),
                            //   child: Align(
                            //     alignment: Get.locale!.languageCode == 'ar'
                            //         ? Alignment.centerLeft
                            //         : Alignment.centerRight,
                            //     child: Text(
                            //       "forgetPassword".tr,
                            //       style: TextStyle(fontSize: 14),
                            //     ),
                            //   ),
                            // )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: _submit,
                    child: saveButtonBig(
                        title: "login".tr,
                        image: 'assets/images/next_circle.png',
                        context: context),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don'tHaveAccount".tr,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "REgister".tr,
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
