import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rooj/screens/ReservationsDetails/ReservationsDetails.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:rooj/providerModel/reservationsProvider.dart' as Reservations;

class ReservaionWidget extends StatelessWidget {
  final List<Reservations.Datum> items;

  const ReservaionWidget({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () => Get.to(
                () => ReservationsDetailsScreen(
                  id: items[index].id,
                ),
                transition: Transition.zoom,
              ),
              child: Column(
                children: [
                  Container(
                    height: height(context) * 0.15,
                    width: width(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: height(context) * 0.12,
                            height: height(context) * 0.11,
                            child: items[index].image.isEmpty
                                ? Image.asset(
                                    'assets/images/app_icon2.png',
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    items[index].image[0].imagePath ?? '',
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/app_icon2.png');
                                    },
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: width(context) * 0.018,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: Image.asset(
                                        'assets/images/calender_color.png')),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                    '${DateFormat('yyyy-MM-dd').format(items[index].bookingDate)}  ${items[index].bookingTime.toString().substring(0, 5)}'),
                              ],
                            ),
                            SizedBox(
                              height: height(context) * 0.012,
                            ),
                            Row(
                              children: [
                                Text(items[index].salonName.toString()),
                                SizedBox(
                                  width: width(context) * 0.1,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: Image.asset(
                                          'assets/images/cashh.png'),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '${items[index].total} ريال',
                                      style:
                                          TextStyle(color: AppColors.mainColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
