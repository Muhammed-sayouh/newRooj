import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/providerModel/reservationDetailsPRovider.dart' as Res;
import 'package:rooj/screens/confirmBooking/customconfirmBookingWidget.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class ReservationsDetailsScreen extends StatefulWidget {
  final int id;

  const ReservationsDetailsScreen({Key? key, required this.id})
      : super(key: key);
  @override
  _ReservationsDetailsScreenState createState() =>
      _ReservationsDetailsScreenState();
}

class _ReservationsDetailsScreenState extends State<ReservationsDetailsScreen> {
  bool loaderO = false;
  Res.Data? data;
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      await Provider.of<Res.ReservationsDetialsProvider>(context, listen: false)
          .fetchReservations(widget.id.toString());
      data =
          Provider.of<Res.ReservationsDetialsProvider>(context, listen: false)
              .data;
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

  String getMyTime(String time) {
    if (int.parse(time.substring(0, 2)) > 12) {
      return '${int.parse(time.substring(0, 2)) - 12}${time.substring(2, 5)} ${'pm'.tr}';
    } else {
      return "${time.substring(0, 5)} ${'am'.tr}";
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
      appBar: myAppBarRservationsDetails(
        title: 'Reservation details'.tr,
        inMain: false,
      ),
      body: loaderO
          ? loadingDialogForPages(context)
          : stackWidget(
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
                        name: data!.salonName,
                        adress: '',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      AdressWidget(
                        date:
                            '${data!.bookingDate.toString().substring(0, 10)}   ${getMyTime(data!.bookingTime.toString())}',
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            "Services".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: height(context) * 0.3,
                        width: width(context),
                        child: ListView.builder(
                          itemCount: data!.services.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: width(context) * 0.4,
                                        height: height(context) * 0.2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            'assets/images/app_icon2.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
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
                                        data!.services[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // Text(
                                      //   '${ data!.services[index]..toString()} فرد',
                                      //   style: TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.grey,
                                      //   ),
                                      // ),
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
                                        data!.services[index].duration
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        data!.services[index].price.toString(),
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
                        "Invoice Details".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RowWidget2(
                        total: data!.total.toString(),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'الدفع',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            data!.paymentMethodId == 1
                                ? Container(
                                    width: width(context) * 0.38,
                                    height: height(context) * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: AppColors.mainColor)),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width(context) * 12,
                                          height: 50,
                                          child: Image.asset(
                                            'assets/images/online_money.png',
                                          ),
                                        ),
                                        Text("Online payment".tr)
                                      ],
                                    )),
                                  )
                                : Container(
                                    width: width(context) * 0.38,
                                    height: height(context) * 0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: AppColors.mainColor)),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width(context) * 12,
                                          height: 50,
                                          child: Image.asset(
                                            'assets/images/mony.png',
                                          ),
                                        ),
                                        Text("Cash payment".tr),
                                      ],
                                    )),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              context: context),
    );
  }
}
