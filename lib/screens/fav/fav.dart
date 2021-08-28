import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Favorite'.tr, inMain: false),
      body: Container(
        width: width(context),
        height: height(context),
        child: GetStorageHelper.getToken() == ""
            ? Center(child: Text('Please login first'.tr))
            : Center(
                child: Text('You dont have any items in your favourites'.tr)),
      ),
    );
  }
}
