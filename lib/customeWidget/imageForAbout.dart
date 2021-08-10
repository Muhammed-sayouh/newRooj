import 'package:flutter/material.dart';
import 'package:rooj/style/sizes.dart';

class ImageWidgetForAbout extends StatelessWidget {
  const ImageWidgetForAbout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width(context) * 0.4,
        height: height(context) * 0.3,
        child: Image.asset(
          'assets/images/app_logo.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ImageWidgetForRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width(context) * 0.5,
        height: height(context) * 0.3,
        child: Image.asset(
          'assets/images/rate_now.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
