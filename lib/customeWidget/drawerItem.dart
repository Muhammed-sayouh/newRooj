import 'package:flutter/cupertino.dart';

Widget drawerItem({required IconData iconData, required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(iconData),
      SizedBox(
        width: 6,
      ),
      Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
