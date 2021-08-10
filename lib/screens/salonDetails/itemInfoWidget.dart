import 'package:flutter/material.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class ItemInfoWidget extends StatelessWidget {
  final String name;
  final String duration;
  final String price;
  final String offer;

  const ItemInfoWidget(
      {Key? key,
      required this.name,
      required this.duration,
      required this.price,
      required this.offer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(context) * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Container(
              width: width(context) * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المزيد',
                    style: TextStyle(
                        fontSize: 12, decoration: TextDecoration.underline),
                  ),
                  Text(
                    duration,
                    style: TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        offer,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
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
