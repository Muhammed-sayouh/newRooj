import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/providerModel/homeProvider.dart';
import 'package:rooj/screens/home/clipperWidget.dart';
import 'package:rooj/screens/home/listWidget.dart';
import 'package:rooj/screens/salonsCategories/salonsCategories.dart';
import 'package:rooj/screens/search/search.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

import 'clipper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  bool loaderO = false;
  List<Datum> homeItems = [];
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      homeItems =
          await Provider.of<HomeProvider>(context, listen: false).fetchHome();
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
    print(GetStorageHelper.getToken());
    return Container(
      width: width(context),
      height: height(context),
      color: AppColors.mainBackGroundColor,
      child: Column(
        children: [
          Container(
            height: height(context) * 0.32,
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
                          top: height(context) * 0.07,
                          left: 10,
                          right: 10,
                          child: clipperWidget(context),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: height(context) * 0.225,
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
                    child: InkWell(
                      onTap: () => Get.to(() => SearchScreen(),
                          transition: Transition.zoom),
                      child: MyTextFormFieldWithImageClicable(
                        obscureText: false,
                        hint: "HomeSearch".tr,
                        image: 'assets/images/search_icon.png',
                        controller: search,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          loaderO
              ? Center(child: loadingDialogForPages(context))
              : Expanded(
                  child: ListView.builder(
                    itemCount: homeItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.to(
                          () => SalonCategoriesScreen(
                            salonId: homeItems[index].id.toInt(),
                            salonName: homeItems[index].name.toString(),
                          ),
                          transition: Transition.zoom,
                        ),
                        child: HomeCardWidget(
                          count: homeItems[index].salonCount.toString(),
                          image: homeItems[index].imagePath,
                          name: homeItems[index].name,
                        ),
                      );
                    },
                  ),
                ),
          SizedBox(
            height: height(context) * 0.1,
          )
        ],
      ),
    );
  }
}
