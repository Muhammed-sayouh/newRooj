import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/bkAuth.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/screens/pinCodeVendor/pinCodeVendor.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';
import 'package:rooj/style/sizes.dart';

class EnterPhoneForVendorScreen extends StatefulWidget {
  @override
  _EnterPhoneForVendorScreenState createState() =>
      _EnterPhoneForVendorScreenState();
}

class _EnterPhoneForVendorScreenState extends State<EnterPhoneForVendorScreen> {
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
          .enterPhoneUser(phone.text, 1);
      code = Provider.of<Auth>(context, listen: false).code;
    } on HttpExeption catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("The phone number is already in use".tr, context);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("The phone number is already in use".tr, context);
    } finally {
      if (auth) {
        Get.to(
            () => PinCodeForVendorScreen(
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
                      child: MyTextFormFieldWithImage(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
