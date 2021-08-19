import 'package:flutter/material.dart';

import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'الخدمات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          'اضف خدمه',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
      ],
    );
  }
}

class RowWidget3 extends StatelessWidget {
  final String total;
  final int count;
  const RowWidget3({
    Key? key,
    required this.total,
    required this.count,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'تكلفة الافراد',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Spacer(),
        Text(
          '$count فرد * 15 ريال = $total ريال',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
      ],
    );
  }
}

class RowWidget2 extends StatelessWidget {
  final String total;

  const RowWidget2({
    Key? key,
    required this.total,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'الاجمالي',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Spacer(),
        Text(
          "$total ريال",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
      ],
    );
  }
}

class RowWidget4 extends StatelessWidget {
  final String total;

  const RowWidget4({
    Key? key,
    required this.total,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'تكلفة الخدمات',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Spacer(),
        Text(
          "$total ريال",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
      ],
    );
  }
}

class AdressWidget extends StatelessWidget {
  final String date;

  const AdressWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 15,
            height: 15,
            child: Image.asset('assets/images/calender_color.png')),
        SizedBox(
          width: 3,
        ),
        Text(date),
      ],
    );
  }
}

class NameAndAdressWidget extends StatelessWidget {
  final String adress;
  final String name;
  final String image;

  const NameAndAdressWidget(
      {Key? key, required this.adress, required this.name, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 60,
              height: 60,
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: width(context) * 0.6,
            height: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  width: width(context) * 0.6,
                  child: Text(
                    adress,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
