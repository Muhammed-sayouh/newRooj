import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/screens/salonDetails/itemInfoWidget.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

import 'addetionalPersonModel.dart';

class ServicesMoreDetailsScreen extends StatefulWidget {
  final String name;
  final String price;
  final String duration;

  const ServicesMoreDetailsScreen(
      {Key? key,
      required this.name,
      required this.price,
      required this.duration})
      : super(key: key);
  @override
  _ServicesMoreDetailsScreenState createState() =>
      _ServicesMoreDetailsScreenState();
}

class _ServicesMoreDetailsScreenState extends State<ServicesMoreDetailsScreen> {
  List<AdditionalPersonModel> services = [];

  void getWorkers() {
    services =
        Provider.of<AdditionalPersonProvider>(context, listen: false).services;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => getWorkers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.mainBackGroundColor,
        width: width(context),
        height: height(context),
        child: Column(
          children: [
            Container(
              height: height(context) * 0.5,
              child: Stack(
                children: [
                  Container(
                    height: height(context) * 0.38,
                    width: width(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200),
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
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Expanded(
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
                            duration: services[index].duration.toString(),
                            name: services[index].name.toString(),
                            offer: "",
                            price: services[index].priceTxt.toString(),
                          ),
                          Container(
                            width: width(context) * 0.2,
                            height: height(context) * 0.075,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: services.length),
            ),
          ],
        ),
      ),
    );
  }
}
