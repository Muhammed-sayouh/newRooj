import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/citeisProvider.dart';
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

  bool loaderO = false;
  List<Datum> homeItems = [];
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      homeItems = await Provider.of<CitiesProvider>(context, listen: false)
          .fetchCities();
      setState(() {
        loaderO = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        loaderO = false;
      });
      print(error);

      throw (error);
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
      backgroundColor: AppColors.mainBackGroundColor,
      appBar: myAppBar(title: "ChangeCity".tr, inMain: false),
      body: stackWidget(
        body: Column(
          children: [
            SizedBox(
              height: height(context) * 0.03,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: homeItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          homeItems[index].selected =
                              !homeItems[index].selected;
                        });
                      },
                      child: Container(
                        width: width(context),
                        height: height(context) * 0.08,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: homeItems[index].selected
                                      ? AppColors.mainColor
                                      : Colors.black)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width(context) * 0.03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.mainColor, width: 2),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width(context) * 0.05,
                                ),
                                Text(
                                  homeItems[index].name.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
            // ...cities
            //     .map(
            //       (e) => Padding(
            //         padding: EdgeInsets.symmetric(
            //             horizontal: width(context) * 0.02,
            //             vertical: height(context) * 0.01),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(50),
            //             border: Border.all(),
            //           ),
            //           child: RadioListTile<String>(
            //             activeColor: AppColors.mainColor,
            //             toggleable: true,
            //             title: Text(e),
            //             value: e,
            //             groupValue: _character,
            //             onChanged: (String? value) {
            //               setState(() {
            //                 _character = value;
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //     )
            //     .toList(),