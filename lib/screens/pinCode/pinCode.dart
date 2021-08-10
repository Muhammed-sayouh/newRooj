import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rooj/customeWidget/bkAuth.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'ادخال الكود',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.2),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      onChanged: (val) {},
                      cursorColor: AppColors.mainColor,
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        inactiveColor: AppColors.mainColor,
                        activeColor: AppColors.mainColor,
                        activeFillColor: AppColors.textFieldIconBackColor,
                        disabledColor: AppColors.textFieldIconBackColor,
                        inactiveFillColor: AppColors.textFieldIconBackColor,
                        selectedColor: AppColors.mainColor,
                        selectedFillColor: AppColors.textFieldIconBackColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text('اعادة ارسال'),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  InkWell(
                    onTap: () => Get.to(
                      () => MainPage(
                        index: 3,
                      ),
                      transition: Transition.zoom,
                    ),
                    child: saveButton(
                        title: 'التالي',
                        image: 'assets/images/next_circle.png'),
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
