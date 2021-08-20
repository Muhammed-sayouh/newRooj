import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/bkAuth.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/spalsh/splashScreen.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';
import 'package:rooj/style/sizes.dart';

class RegisterForVendorScreen extends StatefulWidget {
  final String phone;

  const RegisterForVendorScreen({Key? key, required this.phone})
      : super(key: key);
  @override
  _RegisterForVendorScreenState createState() =>
      _RegisterForVendorScreenState();
}

class _RegisterForVendorScreenState extends State<RegisterForVendorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController identy = TextEditingController();
  TextEditingController insta = TextEditingController();

  XFile? chosenImages;
  XFile? _pickImageError;
  Future<void> picImages() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        chosenImages = image;
      });
    } catch (e) {
      chosenImages = _pickImageError;
    }
  }

  Future<void> _submit() async {
    bool auth = Provider.of<Auth>(context, listen: false).isRegisteredVendor;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      auth = await Provider.of<Auth>(context, listen: false).registerVendor(
          name: name.text,
          phone: widget.phone,
          email: email.text,
          password: password.text,
          id: identy.text,
          insta: insta.text,
          image: chosenImages);
    } on HttpExeption catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("البريد الالكتروني مستخدم من قبل", context);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("يرجي التحقق من الانترنت", context);
    } finally {
      if (auth) {
        Navigator.of(context).pop();
        customSnackBar(
            title: 'تم التسجيل',
            content:
                "تم التسجيل بنجاح يرجي تسجيل الدخول للاستمتاع بخدمات التطبيق ");
        Future.delayed(Duration(
          seconds: 3,
        )).then((value) =>
            Get.offAll(() => SplashScreen(), transition: Transition.zoom));
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
                            obscureText: false,
                            controller: name,
                            hint: 'الاسم',
                            image: 'assets/images/user_off.png',
                            validator: (value) {
                              if (value!.isEmpty) {
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
                            obscureText: false,
                            controller: password,
                            hint: 'كلمة المرور',
                            image: 'assets/images/lock_line.png',
                            validator: (value) {
                              if (value!.isEmpty) {
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
                            obscureText: false,
                            controller: identy,
                            hint: 'رقم الهوية او السجل التجارى',
                            image: 'assets/images/smart_phone_line.png',
                            validator: (value) {
                              if (value!.isEmpty) {
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
                            obscureText: false,
                            controller: email,
                            hint: 'الايميل',
                            image: 'assets/images/message.png',
                            validator: (value) {
                              if (value!.isEmpty) {
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
                            obscureText: false,
                            controller: insta,
                            hint: 'الانستقرام',
                            image: 'assets/images/instegram_line.png',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Thisfieldisrequired".tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 33,
                                height: 33,
                                margin: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: AppColors.textFieldIconBackColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: Image.asset(
                                      "assets/images/image_placeholder.png"),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: picImages,
                                child: Column(
                                  children: [
                                    Text(
                                      "ارفاق شهاده",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "اختياري",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              chosenImages == null
                                  ? SizedBox()
                                  : SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(
                                            chosenImages!.path,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
