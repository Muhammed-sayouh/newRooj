import 'package:flutter/material.dart';
import 'package:rooj/style/sizes.dart';

class Indecator extends StatelessWidget {
  const Indecator({
    required this.imageList,
    required this.currentIndex,
  });

  final List<String> imageList;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (int i = 0; i < imageList.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Container(
              height: width(context) * 0.03,
              width: width(context) * 0.03,
              decoration: BoxDecoration(
                color: i == currentIndex ? Colors.white : Colors.white54,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
      ]),
    );
  }
}
