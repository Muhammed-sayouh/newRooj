import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/cardWidget.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/customeWidget/wavy_header_image.dart';
import 'package:rooj/screens/vendorProfile/rowWidget/rowWidget.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class VendorProfileScreen extends StatefulWidget {
  @override
  _VendorProfileScreenState createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: AssetImage('assets/images/bg_icons.png'),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      WavyHeaderImage(),
                      Positioned(
                        bottom: width(context) * 0.18,
                        left: width(context) * 0.015,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _profilePicture()),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'تعديل حسابي',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.05,
                      ),
                      MyTextFormFieldWithImage(
                        obscureText: false,
                        controller: name,
                        hint: 'الاسم',
                        image: 'assets/images/user_off.png',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextFormFieldWithImage(
                        obscureText: false,
                        controller: phone,
                        hint: 'رقم الجوال',
                        image: 'assets/images/smart_phone_line.png',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextFormFieldWithImageAndPerfix(
                        obscureText: true,
                        controller: password,
                        hint: 'الرقم السري',
                        image: 'assets/images/lock_line.png',
                        suffix: 'تغيير',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextFormFieldWithImage(
                        obscureText: false,
                        controller: phone,
                        hint: 'رقم الهوية او السجل التجارى',
                        image: 'assets/images/smart_phone_line.png',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextFormFieldWithImage(
                        obscureText: false,
                        controller: phone,
                        hint: 'الايميل',
                        image: 'assets/images/message.png',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextFormFieldWithImage(
                        obscureText: false,
                        controller: phone,
                        hint: 'الانستقرام',
                        image: 'assets/images/instegram_line.png',
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
                          Column(
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              saveButton(title: 'حفظ', image: 'assets/images/next_circle.png'),
              SizedBox(
                height: height(context) * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.02),
                    child: Text(
                      'المشاغل',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.02),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  CardWidgetForVendorProfile(
                    adress: 'القاهره',
                    desc: 'يقع هذا الصالون في مدينة نصر',
                    title: "مشغل الهام",
                  )
                ],
              ),
              SizedBox(
                height: height(context) * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.02),
                    child: Text(
                      'العروض',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.02),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  CardWidgetForVendorProfile(
                    adress: 'القاهره',
                    desc: 'عرض تخفيض 50 % علي قص الشعر',
                    title: 'قص الشعر',
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  rowWidget(
                      context: context,
                      title: 'الفروع',
                      addString: "اضف فرع",
                      function: () {}),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  rowWidget(
                      context: context,
                      title: 'الخدمات',
                      addString: "اضف خدمه",
                      function: () {}),
                ],
              ),
              SizedBox(
                height: height(context) * 0.15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _profilePicture() {
  return InkWell(
    onTap: () {},
    child: SizedBox(
      height: 150,
      width: 150,
      child: Image.asset(
        'assets/images/profile_circle_white.png',
        fit: BoxFit.fill,
      ),
    ),
  );
}
