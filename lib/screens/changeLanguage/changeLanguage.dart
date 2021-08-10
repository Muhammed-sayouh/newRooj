import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

enum SingingCharacter { Arabic, Englis }

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  SingingCharacter? _character = Get.locale!.languageCode == 'en'
      ? SingingCharacter.Englis
      : SingingCharacter.Arabic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackGroundColor,
      appBar: myAppBar(title: "ChangeLanguage".tr, inMain: true),
      body: stackWidget(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * 0.02,
                  vertical: height(context) * 0.03),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: _character == SingingCharacter.Arabic
                          ? AppColors.mainColor
                          : Colors.grey),
                ),
                child: RadioListTile<SingingCharacter>(
                  activeColor: AppColors.mainColor,
                  toggleable: true,
                  title: Text('العربيه'),
                  value: SingingCharacter.Arabic,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(context) * 0.02,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: _character == SingingCharacter.Englis
                          ? AppColors.mainColor
                          : Colors.grey),
                ),
                child: RadioListTile(
                  activeColor: AppColors.mainColor,
                  title: Text('English'),
                  toggleable: true,
                  value: SingingCharacter.Englis,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: height(context) * 0.1,
            ),
            smallButton(
              context: context,
              title: "save".tr,
              onTap: () {
                if (_character!.index == 0) {
                  Get.updateLocale(Locale('ar'));
                  Future.delayed(Duration(milliseconds: 10)).then(
                    (value) => Get.to(
                      () => MainPage(
                        index: 3,
                      ),
                      transition: Transition.zoom,
                    ),
                  );
                } else {
                  Get.updateLocale(Locale('en'));
                  Future.delayed(Duration(milliseconds: 10)).then(
                    (value) => Get.to(
                      () => MainPage(
                        index: 3,
                      ),
                      transition: Transition.zoom,
                    ),
                  );
                }
              },
            )
          ],
        ),
        context: context,
      ),
    );
  }
}
