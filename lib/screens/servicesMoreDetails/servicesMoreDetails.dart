import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/salonServicesProvider.dart';
import 'package:rooj/screens/salonDetails/itemInfoWidget.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

import 'addetionalPersonModel.dart';

class ServicesMoreDetailsScreen extends StatefulWidget {
  final String name;
  final String price;
  final String duration;
  final int index;
  const ServicesMoreDetailsScreen({
    Key? key,
    required this.name,
    required this.price,
    required this.duration,
    required this.index,
  }) : super(key: key);
  @override
  _ServicesMoreDetailsScreenState createState() =>
      _ServicesMoreDetailsScreenState();
}

class _ServicesMoreDetailsScreenState extends State<ServicesMoreDetailsScreen> {
  List<AdditionalPersonModel> services = [];
  List<AdditionalPersonModel> selected = [];

  bool loaderS = false;
  Future<void> getWorkers() async {
    services =
        Provider.of<AdditionalPersonProvider>(context, listen: false).services;
    Provider.of<AdditionalPersonProvider>(context, listen: false)
        .services
        .forEach((element) {
      element.selected = false;
    });
    setState(() {});
  }

  List<Datum> myList = [];

  Future<void> futureServices() async {
    setState(() {
      loaderS = true;
    });

    try {
      myList =
          Provider.of<SalonServicesProvider>(context, listen: false).myList;

      setState(() {
        loaderS = false;
      });
    } catch (error) {
      setState(() {
        loaderS = false;
      });
      throw (error);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => getWorkers());
    futureServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.mainBackGroundColor,
        width: width(context),
        height: height(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context) * 0.48,
                child: Stack(
                  children: [
                    Container(
                      height: height(context) * 0.38,
                      width: width(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Get.locale!.languageCode == 'en'
                              ? Radius.circular(0)
                              : Radius.circular(200),
                          bottomLeft: Get.locale!.languageCode == 'en'
                              ? Radius.circular(200)
                              : Radius.circular(0),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=871&q=80',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height(context) * 0.33,
                      ),
                      child: Container(
                        width: width(context) * 0.8,
                        height: height(context) * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Get.locale!.languageCode == 'ar'
                                ? Radius.circular(15)
                                : Radius.zero,
                            bottomLeft: Get.locale!.languageCode == 'ar'
                                ? Radius.circular(15)
                                : Radius.zero,
                            topRight: Get.locale!.languageCode == 'ar'
                                ? Radius.zero
                                : Radius.circular(15),
                            bottomRight: Get.locale!.languageCode == 'ar'
                                ? Radius.zero
                                : Radius.circular(15),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.price,
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.duration,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height(context) * 0.05, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                CupertinoIcons.back,
                                color: AppColors.mainColor,
                                size: 35,
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    child: Icon(
                                      Icons.share,
                                      color: AppColors.mainColor,
                                    ),
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    child: Image.asset(
                                      'assets/images/notification_without_dot.png',
                                      color: AppColors.mainColor,
                                    ),
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.04),
                child: Text(
                  'Staff (Optional)'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: width(context),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.06,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.015),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('without preference'.tr),
                            Icon(
                              Icons.arrow_downward_rounded,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.04),
                child: Text(
                  "other choices".tr,
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              loaderS
                  ? loadingDialogForSmallestPages(context)
                  : Container(
                      height: height(context) * 0.3,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              width: width(context),
                              height: height(context) * 0.1,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  ItemInfoWidgetFoSirv(
                                    duration:
                                        services[index].duration.toString(),
                                    name: services[index].name.toString(),
                                    offer: "",
                                    price: services[index].priceTxt.toString(),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        services[index].selected =
                                            !services[index].selected;
                                      });
                                      if (services[index].selected) {
                                        //add to main list num. of addetional workers
                                        Provider.of<SalonServicesProvider>(
                                                context,
                                                listen: false)
                                            .myList[widget.index]
                                            .addetionalPresons++;
                                      } else {
                                        Provider.of<SalonServicesProvider>(
                                                context,
                                                listen: false)
                                            .myList[widget.index]
                                            .addetionalPresons--;
                                      }
                                    },
                                    child: Container(
                                      width: width(context) * 0.2,
                                      height: height(context) * 0.1,
                                      decoration: BoxDecoration(
                                        color: services[index].selected
                                            ? AppColors.mainColor
                                            : Colors.white,
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          services[index].selected
                                              ? Icons.check
                                              : Icons.add,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: services.length),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: smallButton(
                    context: context,
                    title: "apply".tr,
                    onTap: () {
                      Future.delayed(Duration.zero).then((value) => Get.back());
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
