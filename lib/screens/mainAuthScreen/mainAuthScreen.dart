import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/bkAuth.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/screens/enterPhoneForVendor/enterPhoneForVendor.dart';
import 'package:rooj/screens/login/login.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/screens/pinCode/pinCode.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';
import 'package:rooj/style/sizes.dart';

class MainAuthScreen extends StatefulWidget {
  const MainAuthScreen({Key? key}) : super(key: key);

  @override
  _MainAuthScreenState createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();

  Future<void> _submit() async {
    int? code = Provider.of<Auth>(context, listen: false).code;
    bool auth = Provider.of<Auth>(context, listen: false).correctUserPhone;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      auth = await Provider.of<Auth>(context, listen: false)
          .enterPhoneUser(phone.text, 0);
      code = Provider.of<Auth>(context, listen: false).code;
    } on HttpExeption catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("رقم الهاتف مستخدم من قبل", context);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("رقم الهاتف مستخدم من قبل", context);
    } finally {
      if (auth) {
        Get.to(
            () => PinCodeScreen(
                  code: code,
                  phone: phone.text,
                ),
            transition: Transition.zoom);
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
                      "signUp".tr,
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
                      child: MyTextFormFieldWithImageAndPerfix(
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
                          } else if (val.length < 6) {
                            return 'Please enter a valid phone number'.tr;
                          } else {
                            return null;
                          }
                        },
                        suffix: '966+',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: _submit,
                    child: saveButton(
                        title: "next".tr,
                        image: 'assets/images/next_circle.png'),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "haveAccount".tr,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () => Get.to(
                          () => LoginScreen(),
                          transition: Transition.zoom,
                        ),
                        child: Text(
                          "login".tr,
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ProviderAccount".tr,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () => Get.to(
                          () => EnterPhoneForVendorScreen(),
                          transition: Transition.zoom,
                        ),
                        child: Text(
                          "signUpNow".tr,
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context) * 0.03,
                  ),
                  InkWell(
                    onTap: () => Get.to(
                      () => MainPage(index: 3),
                      transition: Transition.zoom,
                    ),
                    child: Text(
                      "unAuthEnter".tr,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
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
