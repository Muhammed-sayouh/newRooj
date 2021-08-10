import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/cardWidget.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/providerModel/salonDetailsProvider.dart';
import 'package:rooj/screens/home/clipper.dart';
import 'package:rooj/screens/home/clipperWidget.dart';
import 'package:rooj/screens/salonDetails/salonDetails.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';
import 'package:rooj/style/sizes.dart';

class SalonCategoriesScreen extends StatefulWidget {
  final int salonId;
  final String salonName;
  const SalonCategoriesScreen(
      {Key? key, required this.salonId, required this.salonName})
      : super(key: key);
  @override
  _SalonCategoriesScreenState createState() => _SalonCategoriesScreenState();
}

class _SalonCategoriesScreenState extends State<SalonCategoriesScreen> {
  TextEditingController search = TextEditingController();
  String place = 'in_salon';
  String type = 'latest';

  bool loaderO = false;
  List<Datum> salonDetailsItems = [];
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      salonDetailsItems =
          await Provider.of<SalonDetailsProvider>(context, listen: false)
              .fetchSalonDetails(
        place: place,
        salonId: widget.salonId,
        type: type,
      );
      setState(() {
        loaderO = false;
      });
    } catch (error) {
      setState(() {
        loaderO = false;
      });
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
      body: Column(
        children: [
          Container(
            height: height(context) * 0.23,
            width: width(context),
            child: Stack(
              children: [
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    width: width(context),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: height(context) * 0.04,
                          left: 10,
                          right: 10,
                          child:
                              clipperWidgetForpages(context, widget.salonName),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: height(context) * 0.13,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0),
                          spreadRadius: 10,
                          blurRadius: 3,
                          offset: Offset(4, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: MyTextFormFieldWithImage(
                      obscureText: false,
                      hint: "HomeSearch".tr,
                      image: 'assets/images/search_icon.png',
                      controller: search,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    place = 'in_salon';
                    futureO();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: place == 'in_salon'
                          ? AppColors.mainColor
                          : Colors.white,
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 1,
                      )),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                      child: Text(
                        "inSalon".tr,
                        style: TextStyle(
                          color: place == 'in_home'
                              ? AppColors.mainColor
                              : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    place = 'in_home';
                    futureO();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: place == 'in_home'
                          ? AppColors.mainColor
                          : Colors.white,
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 1,
                      )),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                      child: Text(
                        "inHome".tr,
                        style: TextStyle(
                          color: place == 'in_salon'
                              ? AppColors.mainColor
                              : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    type = 'latest';
                    futureO();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          type == 'latest' ? AppColors.mainColor : Colors.white,
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 1,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Center(
                      child: Text(
                        "Latest".tr,
                        style: TextStyle(
                          color: type == 'latest'
                              ? Colors.white
                              : AppColors.mainColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    type = 'highly_rated';
                    futureO();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: type == 'highly_rated'
                          ? AppColors.mainColor
                          : Colors.white,
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 1,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Center(
                      child: Text(
                        "Highly Rated".tr,
                        style: TextStyle(
                          color: type == 'highly_rated'
                              ? Colors.white
                              : AppColors.mainColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    type = 'city_id';
                    futureO();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: type == 'city_id'
                          ? AppColors.mainColor
                          : Colors.white,
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 1,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Center(
                      child: Text(
                        "The nearest".tr,
                        style: TextStyle(
                          color: type == 'city_id'
                              ? Colors.white
                              : AppColors.mainColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          loaderO
              ? loadingDialogForSmallPages(context)
              : Expanded(
                  child: ListView.builder(
                  itemCount: salonDetailsItems.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.to(
                        () =>
                            SalonDetailsScreen(id: salonDetailsItems[index].id),
                        transition: Transition.zoom,
                      ),
                      child: CardWidget(
                        name: salonDetailsItems[index].name,
                        image: salonDetailsItems[index].images.isEmpty
                            ? ''
                            : salonDetailsItems[index].images.first.imagePath,
                        rate: salonDetailsItems[index].averageReview,
                        adress: salonDetailsItems[index].address,
                      ),
                    );
                  },
                ))
        ],
      ),
    );
  }
}
