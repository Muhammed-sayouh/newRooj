import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooj/style/sizes.dart';

Widget rowWidget(
    {required BuildContext context,
    required String title,
    required String addString,
    required Function function}) {
  return InkWell(
    onTap: () => function,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width(context) * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width(context) * 0.3,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  width: width(context) * 0.27,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: width(context) * 0.01,
                      ),
                      Text(
                        addString,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width(context) * 0.02),
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    ),
  );
}
