import 'package:flutter/material.dart';
import 'package:rooj/style/colors.dart';

class HomeCardWidget extends StatelessWidget {
  final String? name;
  final String? count;
  final String? image;

  const HomeCardWidget({Key? key, this.name, this.count, this.image})
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
                    image: '',
                    placeholder: 'assets/images/app_icon2.png',
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/app_icon2.png');
                    },
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toString(),
                  style: TextStyle(
                    color: AppColors.cardTitleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  count.toString(),
                  style: TextStyle(
                    color: AppColors.cardTitleColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
