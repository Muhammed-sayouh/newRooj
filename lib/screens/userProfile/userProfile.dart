import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/screens/test/test.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loader = false;
  dynamic userInfo;

  Future<void> futureO() async {
    setState(() {
      loader = true;
    });

    try {
      userInfo =
          await Provider.of<Auth>(context, listen: false).getUserProfile();

      name.text = userInfo['client']['name'];
      phone.text = userInfo['client']['phone'];
      setState(() {
        loader = false;
      });
    } catch (error) {
      setState(() {
        loader = false;
      });
      throw (error);
    }
  }

  Future<void> _submit() async {
    bool auth = Provider.of<Auth>(context, listen: false).doneEdaitUserProfile;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      loader = true;
    });
    try {
      auth = await Provider.of<Auth>(context, listen: false).updateUserProfile(
        name.text,
        phone.text,
      );
    } on HttpExeption catch (error) {
      print(error);
      setState(() {
        loader = false;
      });
      showErrorDaialog("NoInternet".tr, context);
    } catch (error) {
      print(error);
      setState(() {
        loader = false;
      });
      showErrorDaialog("NoInternet".tr, context);
    } finally {
      if (auth) {
        futureO().then(
            (value) => customSnackBar(title: "ok".tr, content: "doneEdait".tr));
      }
    }
  }

  @override
  void initState() {
    futureO();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_icons.png'),
              fit: BoxFit.fill),
        ),
        child: GetStorageHelper.getToken() == ""
            ? Center(child: Text('يرجي تسجيل الدخول اولا'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/header.png'),
                                  fit: BoxFit.fill)),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: width(context) * 0.02,
                                left: width(context) * 0.03,
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: _profilePicture()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.04),
                      child: loader
                          ? loadingDialogForSmallestPages(context)
                          : Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () => Get.to(MyText()),
                                        child: Text(
                                          "edaitProfile".tr,
                                          style: TextStyle(
                                            color: AppColors.mainColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  MyTextFormFieldWithImage(
                                    obscureText: false,
                                    controller: name,
                                    hint: "nameD".tr,
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
                                    controller: phone,
                                    hint: "phone".tr,
                                    image: 'assets/images/smart_phone_line.png',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Thisfieldisrequired".tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.05),
                      child: Text(
                        "Change Password".tr,
                        style: TextStyle(
                          color: AppColors.mainColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: InkWell(
                          onTap: _submit,
                          child: saveButton(
                              title: "save".tr,
                              image: 'assets/images/next_circle.png')),
                    ),
                    SizedBox(
                      height: height(context) * 0.15,
                    ),
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
      height: 120,
      width: 120,
      child: Image.asset(
        'assets/images/profile_circle_white.png',
        fit: BoxFit.fill,
      ),
    ),
  );
}
