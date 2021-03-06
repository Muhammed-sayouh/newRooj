import 'package:flutter/material.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';

class OfferCardWidget extends StatelessWidget {
  final String name;
  final String percentage;
  final String image;

  const OfferCardWidget(
      {Key? key,
      required this.name,
      required this.percentage,
      required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.mainColor,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  // shape: BoxShape.circle
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    image: image,
                    placeholder: 'assets/images/app_icon2.png',
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/app_icon2.png');
                    },
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: AppColors.cardTitleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: AppColors.mainColor,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    ' ${"discount percentage".tr} $percentage% ',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
