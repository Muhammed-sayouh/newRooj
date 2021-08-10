import 'package:flutter/material.dart';
import 'package:rooj/style/sizes.dart';

class NotifactionsWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const NotifactionsWidget(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          height: 75,
          child: Image.asset(
            'assets/images/happy.png',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: width(context) * 0.015,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
