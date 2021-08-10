import 'package:flutter/cupertino.dart';
import 'package:rooj/style/sizes.dart';

Widget rowW(
    {required BuildContext context,
    required String firstPrice,
    required String secondePrice}) {
  return Row(
    children: [
      Container(
        width: width(context) * 0.3,
        child: Center(
          child: Text(
            firstPrice,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(
        width: width(context) * 0.15,
      ),
      Container(
        width: width(context) * 0.4,
        child: Center(
          child: Text(
            secondePrice,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
