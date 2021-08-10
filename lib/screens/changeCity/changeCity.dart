import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class ChangeCityScreen extends StatefulWidget {
  @override
  _ChangeCityScreenState createState() => _ChangeCityScreenState();
}

class _ChangeCityScreenState extends State<ChangeCityScreen> {
  String? _character = 'المدينه';

  List<String> cities = ['المدينه', 'مكه', 'الطائف', 'ابها'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackGroundColor,
      appBar: myAppBar(title: "ChangeCity".tr, inMain: false),
      body: stackWidget(
        body: Column(
          children: [
            SizedBox(
              height: height(context) * 0.03,
            ),
            ...cities
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width(context) * 0.02,
                        vertical: height(context) * 0.01),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(),
                      ),
                      child: RadioListTile<String>(
                        activeColor: AppColors.mainColor,
                        toggleable: true,
                        title: Text(e),
                        value: e,
                        groupValue: _character,
                        onChanged: (String? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                )
                .toList(),
            SizedBox(
              height: height(context) * 0.1,
            ),
            smallButton(
              context: context,
              title: "save".tr,
              onTap: () {},
            )
          ],
        ),
        context: context,
      ),
    );
  }
}
