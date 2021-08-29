import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/providerModel/bookProvider.dart';
import 'package:rooj/providerModel/salonServicesProvider.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/screens/map/map.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

import 'customconfirmBookingWidget.dart';

class ConFirmBookingScreen extends StatefulWidget {
  final String adress;
  final String name;
  final String place;
  final String image;
  final String selectedTime;
  final String selectedDate;
  final int salonId;
  const ConFirmBookingScreen(
      {Key? key,
      required this.adress,
      required this.place,
      required this.salonId,
      required this.name,
      required this.image,
      required this.selectedDate,
      required this.selectedTime})
      : super(key: key);
  @override
  _ConFirmBookingScreenState createState() => _ConFirmBookingScreenState();
}

class _ConFirmBookingScreenState extends State<ConFirmBookingScreen> {
  TextEditingController promo = TextEditingController();
  String? addresss;
  double? lat;
  double? lng;
  bool payMent = false;
  double totalPrice() {
    double sum = 0;
    List<Datum> newList =
        Provider.of<SalonServicesProvider>(context, listen: false).newList;
    setState(() {
      for (var i = 0; i < newList.length; i++) {
        sum += (15 * newList[i].addetionalPresons);
      }
    });
    return sum;
  }

  int totalPersons() {
    int sum = 0;
    List<Datum> newList =
        Provider.of<SalonServicesProvider>(context, listen: false).newList;
    setState(() {
      for (var i = 0; i < newList.length; i++) {
        sum += newList[i].addetionalPresons;
      }
    });
    return sum;
  }

  Future<void> _submit(List<Datum> services) async {
    print('1');
    bool done = Provider.of<BookingProiver>(context, listen: false).done;

    showDaialogLoader(context);
    try {
      done = await Provider.of<BookingProiver>(context, listen: false).book(
        salonId: widget.salonId,
        time: widget.selectedTime,
        date: widget.selectedDate,
        additional: totalPersons(),
        payMent: payMent ? 1 : 0,
        services: services,
        lat: widget.place == 'in_salon' ? 0 : double.parse(lat.toString()),
        lag: widget.place == 'in_salon' ? 0 : double.parse(lng.toString()),
      );
    } on HttpExeption catch (error) {
      print(error);
      Get.back();
      showErrorDaialog("This Date is already booked".tr, context);
    } catch (error) {
      print(error);
      Get.back();
      Get.back();
      customSnackBar(title: "Booked".tr, content: "Succsessfully Booked".tr);
      Future.delayed(Duration(seconds: 2)).then(
        (value) => Get.offAll(
          () => MainPage(index: 3),
        ),
      );
      // showErrorDaialog("This Date is already booked".tr, context);
    } finally {
      if (done) {
        Get.back();
        customSnackBar(title: "Booked".tr, content: "Succsessfully Booked".tr);
        Future.delayed(Duration(seconds: 2)).then(
          (value) => Get.offAll(
            () => MainPage(index: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final myProvider =
        Provider.of<SalonServicesProvider>(context, listen: false);
    return Scaffold(
      appBar: myAppBar(title: "Confirm Booking".tr, inMain: false),
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
                    name: widget.name,
                    adress: widget.adress,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AdressWidget(
                    date:
                        '${widget.selectedDate.substring(0, 10)}   ${widget.selectedTime.substring(8)}${widget.selectedTime.substring(0, 5)}',
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
                      itemCount: myProvider.newList.length,
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
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        'assets/images/app_icon2.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          myProvider.removeFromList(myProvider
                                              .newList[index].id!
                                              .toInt());
                                        });
                                      },
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      ),
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
                                  Container(
                                    width: width(context) * 0.23,
                                    child: Text(
                                      myProvider.newList[index].name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${myProvider.newList[index].addetionalPresons.toString()} ${"Preson".tr}',
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
                                    myProvider.newList[index].duration
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    myProvider.newList[index].price.toString(),
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
                  MyTextFormFieldWithPerfix(
                      hint: "Bromo Code".tr,
                      obscureText: false,
                      suffix: "Active".tr,
                      controller: promo),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  totalPersons() == 0
                      ? SizedBox()
                      : RowWidget3(
                          total: totalPrice().toString(),
                          count: totalPersons()),
                  RowWidget4(
                    total: myProvider.getTotal().toString(),
                  ),
                  RowWidget2(
                    total: (totalPrice() + myProvider.getTotal()).toString(),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.place == 'in_salon'
                      ? SizedBox()
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).push<LocationModel>(
                                PageRouteBuilder(pageBuilder: (_, __, ___) {
                              return PickLocation();
                            })).then((location) {
                              lat = location!.lat;
                              lng = location.lng;

                              setState(() {});
                            });
                          },
                          child: Container(
                            width: width(context),
                            height: 58,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: AppColors.mainColor)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    lat == null
                                        ? "select my location".tr
                                        : "your location has been selected".tr,
                                    style: TextStyle(
                                      color: lat == null
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.map,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "payment".tr,
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
                        Container(
                          width: width(context) * 0.38,
                          height: height(context) * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              payMent = !payMent;
                            });
                          },
                          child: Container(
                            width: width(context) * 0.38,
                            height: height(context) * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: payMent
                                        ? AppColors.mainColor
                                        : Colors.grey)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: InkWell(
                      onTap: lat == null && widget.place == 'in_home'
                          ? () => customSnackBar(
                              title: "error".tr,
                              content: "Please select your location".tr)
                          : payMent == false
                              ? () => customSnackBar(
                                    title: "error".tr,
                                    content: "Please select Payment way".tr,
                                  )
                              : () => _submit(myProvider.newList),
                      child: saveButton(
                          title: "Confirm".tr,
                          image: 'assets/images/next_circle.png'),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
          context: context),
    );
  }
}

class LocationModel {
  final double? lat;
  final double? lng;

  const LocationModel({
    this.lat,
    this.lng,
  });
}
