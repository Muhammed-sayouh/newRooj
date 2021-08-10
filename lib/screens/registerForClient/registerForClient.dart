import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/bkAuth.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/screens/pinCode/pinCode.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';
import 'package:rooj/style/sizes.dart';

class RegisterForClientScreen extends StatefulWidget {
  @override
  _RegisterForClientScreenState createState() =>
      _RegisterForClientScreenState();
}

class _RegisterForClientScreenState extends State<RegisterForClientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

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
                      "REgister".tr,
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
                            MyTextFormFieldWithImage(
                              controller: phone,
                              hint: "phonee".tr,
                              image: 'assets/images/smart_phone_line.png',
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MyTextFormFieldWithImage(
                              obscureText: true,
                              controller: password,
                              hint: "password".tr,
                              image: 'assets/images/lock_line.png',
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () => Get.to(
                      () => PinCodeScreen(),
                      transition: Transition.zoom,
                    ),
                    child: saveButton(
                      title: "REgister".tr,
                      image: 'assets/images/next_circle.png',
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
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
