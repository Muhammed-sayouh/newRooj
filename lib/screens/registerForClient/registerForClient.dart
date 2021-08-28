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

class RegisterForClientScreen extends StatefulWidget {
  final String phone;

  const RegisterForClientScreen({Key? key, required this.phone})
      : super(key: key);
  @override
  _RegisterForClientScreenState createState() =>
      _RegisterForClientScreenState();
}

class _RegisterForClientScreenState extends State<RegisterForClientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  Future<void> _submit() async {
    bool auth = Provider.of<Auth>(context, listen: false).isRegisteredUser;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      auth = await Provider.of<Auth>(context, listen: false)
          .registerUser(name.text, widget.phone, email.text, password.text);
    } on HttpExeption catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("Email is already in use".tr, context);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("NoInternet".tr, context);
    } finally {
      if (auth) {
        Get.offAll(() => MainPage(index: 3), transition: Transition.zoom);
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
                              controller: name,
                              hint: "namee".tr,
                              image: 'assets/images/user_off.png',
                              obscureText: false,
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
                            MyTextFormFieldWithImage(
                              controller: email,
                              hint: "email".tr,
                              image: 'assets/images/smart_phone_line.png',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
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
                            MyTextFormFieldWithImage(
                              obscureText: true,
                              controller: password,
                              hint: "password".tr,
                              image: 'assets/images/lock_line.png',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Thisfieldisrequired".tr;
                                } else if (val.length < 8) {
                                  return 'The password must be at least 8 letters or numbers'
                                      .tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: _submit,
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
