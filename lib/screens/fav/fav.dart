import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/style/sizes.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'المفضله', inMain: false),
      body: Container(
        width: width(context),
        height: height(context),
        child: GetStorageHelper.getToken() == ""
            ? Center(child: Text('يرجي تسجيل الدخول اولا'))
            : Center(child: Text('لا يوجد لديك اي عناصر في المفضله')),
      ),
    );
  }
}
