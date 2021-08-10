import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/resirvationWidget.dart';
import 'package:rooj/providerModel/reservationsProvider.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  int page = 1;

  bool loaderO = false;
  List<Datum> items = [];
  Future<void> futureO(String state) async {
    setState(() {
      loaderO = true;
    });

    try {
      items = await Provider.of<ReservationsProvider>(context, listen: false)
          .fetchReservations(state);
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
    futureO('pending');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackGroundColor,
      appBar: myAppBar(title: "Reservations".tr, inMain: true),
      body: stackWidget(
        body: Column(
          children: [
            SizedBox(
              height: height(context) * 0.013,
            ),
            Container(
              height: height(context) * 0.09,
              width: width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        page = 1;
                        futureO('pending');
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "Upcoming reservations".tr,
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                page == 1 ? AppColors.mainColor : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 2,
                          width: width(context) * 0.23,
                          color: page == 1 ? AppColors.mainColor : Colors.white,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        page = 2;
                      });
                      futureO('active');
                    },
                    child: Column(
                      children: [
                        Text(
                          "Pending reservations".tr,
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                page == 2 ? AppColors.mainColor : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 2,
                          width: width(context) * 0.23,
                          color: page == 2 ? AppColors.mainColor : Colors.white,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        page = 3;
                      });
                      futureO('finished');
                    },
                    child: Column(
                      children: [
                        Text(
                          "reservations History".tr,
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                page == 3 ? AppColors.mainColor : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 2,
                          width: width(context) * 0.23,
                          color: page == 3 ? AppColors.mainColor : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loaderO
                ? loadingDialogForPages(context)
                : items.isEmpty
                    ? Center(
                        child: Center(
                            child: Padding(
                        padding: EdgeInsets.only(top: height(context) * 0.28),
                        child: Text(
                          'لا يوجد حجوزات',
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )))
                    : ReservaionWidget(
                        items: items,
                      ),
            Container(
              height: height(context) * 0.065,
            ),
          ],
        ),
        context: context,
      ),
    );
  }
}
