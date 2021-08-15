import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

import 'customconfirmBookingWidget.dart';

class ConFirmBookingScreen extends StatefulWidget {
  @override
  _ConFirmBookingScreenState createState() => _ConFirmBookingScreenState();
}

class _ConFirmBookingScreenState extends State<ConFirmBookingScreen> {
  TextEditingController promo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'تاكيد الحجز', inMain: false),
      body: stackWidget(
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width(context) * 0.04,
                vertical: height(context) * 0.02),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameAndAdressWidget(
                    image:
                        "https://s2.best-wallpaper.net/wallpaper/1280x800/1111/Vector-woman-pink-stylish_1280x800.jpg",
                    name: 'سبا العناية الاسيوى',
                    adress: 'الرياض, شارع الملك فهد',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AdressWidget(
                    date: '2021-03-04',
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  RowWidget(),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: height(context) * 0.3,
                    width: width(context),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Stack(
                                children: [
                                  Container(
                                    width: width(context) * 0.4,
                                    height: height(context) * 0.2,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width(context) * 0.38,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'قص شعر',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '1 فرد',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width(context) * 0.38,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '15 دقيقه',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '500 ريال',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.mainColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    'تفاصيل الفاتورة',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextFormFieldWithPerfix(
                      hint: "برومو كود",
                      obscureText: false,
                      suffix: 'تفعيل',
                      controller: promo),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RowWidget2(),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),
          context: context),
    );
  }
}


// '${DateFormat('yyyy-MM-dd').format(items[index].bookingDate)}  ${items[index].bookingTime.toString().substring(0, 5)}'