import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/providerModel/choseTimeProvider.dart';
import 'package:rooj/screens/confirmBooking/confirBooking.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class ChooseTimeScreen extends StatefulWidget {
  final String adress;
  final String name;
  final String image;
  final int salonId;
  const ChooseTimeScreen(
      {Key? key,
      required this.adress,
      required this.name,
      required this.image,
      required this.salonId})
      : super(key: key);
  @override
  _ChooseTimeScreenState createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  DateTime? currentDate;
  DateTime? reservationDate;
  String? selectedTime;
  bool loaderO = false;
  List<Appointment> times = [];
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      times = await Provider.of<ChoseTimeProvider>(context, listen: false)
          .fetchTimes();
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
    print(reservationDate);
    return Scaffold(
      appBar: myAppBar(title: 'اختيار الوقت والتاريخ', inMain: false),
      body: stackWidgetFullPageSmallappBar(
        context: context,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height(context) * 0.01,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CalendarCarousel<Event>(
                      isScrollable: false,
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      onDayPressed: (DateTime date, List<Event> events) {
                        reservationDate = date;

                        this.setState(() {
                          currentDate = date;
                          reservationDate = date;
                        });
                      },
                      weekendTextStyle: TextStyle(
                        color: Colors.black,
                      ),
                      iconColor: AppColors.mainColor,
                      weekdayTextStyle: TextStyle(fontSize: 10),
                      todayTextStyle: TextStyle(color: Colors.black),
                      selectedDayTextStyle: TextStyle(),
                      headerTextStyle: TextStyle(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      selectedDayButtonColor: AppColors.mainColor,
                      selectedDayBorderColor: AppColors.mainColor,
                      daysTextStyle: TextStyle(
                        color: Colors.black,
                      ),
                      weekFormat: false,
                      locale: Get.locale!.languageCode,
                      markedDatesMap: null,
                      height: 420.0,
                      selectedDateTime: currentDate,
                      daysHaveCircularBorder: true,
                      todayButtonColor: Colors.white,
                      minSelectedDate:
                          DateTime.now().subtract(Duration(days: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'المواعيد المتاحه',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                    fontSize: 18,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      loaderO
                          ? loadingDialogForSmallPages(context)
                          : Container(
                              height: height(context) * 0.35,
                              child: GridView.builder(
                                itemCount: times.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1.7),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        times.forEach((element) {
                                          element.selected = false;
                                        });

                                        times[index].selected =
                                            !times[index].selected;
                                      });
                                      selectedTime = times[index].newTime;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: times[index].selected
                                            ? AppColors.mainColor
                                            : Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${times[index].newTime.substring(0, 5)} ${times[index].newTime.substring(times[index].newTime.length - 2)}",
                                          maxLines: 1,
                                          style: TextStyle(
                                            // fontSize: 13,
                                            color: times[index].selected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: currentDate == null || selectedTime == null
                              ? () => customSnackBar(
                                  title: "sorry".tr,
                                  content: "chooseTimeAndDate".tr)
                              : () => Get.to(
                                  () => ConFirmBookingScreen(
                                        adress: widget.adress,
                                        name: widget.name,
                                        image: widget.image,
                                        selectedDate: currentDate.toString(),
                                        selectedTime: selectedTime.toString(),
                                        salonId: widget.salonId,
                                      ),
                                  transition: Transition.zoom),
                          child: saveButton(
                              title: "next".tr,
                              image: 'assets/images/next_circle.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
