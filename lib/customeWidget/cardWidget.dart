import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final String image;
  final String rate;
  final String adress;

  const CardWidget(
      {Key? key,
      required this.name,
      required this.image,
      required this.rate,
      required this.adress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Container(
        width: width(context),
        height: 250,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 9,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                image,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 130,
                    child: Image.asset(
                      'assets/images/app_icon2.png',
                      fit: BoxFit.fill,
                    ),
                  );
                },
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
                height: 130,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
              width: 60,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.white,
                        size: 17,
                      ),
                      Text(
                        rate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Icon(CupertinoIcons.placemark_fill),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Text(
                      adress,
                      style: TextStyle(
                        color: AppColors.mainColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidgetFav extends StatelessWidget {
  final String name;
  final String image;
  final String rate;
  final String adress;
  final void Function()? function;

  const CardWidgetFav(
      {Key? key,
      required this.name,
      required this.function,
      required this.image,
      required this.rate,
      required this.adress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Container(
            width: width(context),
            height: 250,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 9,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    image,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 130,
                        child: Image.asset(
                          'assets/images/app_icon2.png',
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    height: 130,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                  width: 60,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.white,
                            size: 17,
                          ),
                          Text(
                            rate,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.placemark_fill),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          adress,
                          style: TextStyle(
                            color: AppColors.mainColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Get.locale!.languageCode == 'ar'
              ? Alignment.topLeft
              : Alignment.topRight,
          child: IconButton(
              onPressed: function,
              icon: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              )),
        )
      ],
    );
  }
}

class CardWidgetForVendorProfile extends StatelessWidget {
  final String title;
  final String desc;
  final String adress;
  final String image;
  const CardWidgetForVendorProfile(
      {Key? key,
      required this.title,
      required this.desc,
      required this.adress,
      required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      elevation: 5,
      child: Container(
        width: width(context),
        height: 225,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 9,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                image,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 130,
                    child: Image.asset(
                      'assets/images/app_icon2.png',
                      fit: BoxFit.fill,
                    ),
                  );
                },
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                height: 130,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 9),
              width: width(context) * 0.8,
              height: height(context) * 0.04,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    desc,
                    style: TextStyle(fontSize: 13),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Icon(CupertinoIcons.placemark_fill),
                  SizedBox(
                    width: width(context) * 0.01,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Text(
                      adress,
                      style: TextStyle(
                        color: AppColors.mainColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: width(context) * 0.2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
