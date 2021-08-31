import 'package:flutter/material.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/cardWidget.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/db/db.dart';
import 'package:rooj/db/orderInfo.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/screens/salonDetails/salonDetails.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  late DbHelper _helper;
  List<OrderInfo> _orders = [];

  bool _loading = false;
  Future _getOrders() async {
    try {
      _orders = await _helper.allOrders();
      if (_orders.isNotEmpty) {}
      for (var i = 0; i < _orders.length; i++) {
        print(_orders[i].name);
        print('${_orders[i].saleprice} salePrice');
      }
      setState(() {
        _loading = false;
      });
    } catch (error) {
      print('error');
    }
  }

  @override
  void initState() {
    _helper = DbHelper();
    _getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(_orders[0].itemId);
    return Scaffold(
      appBar: myAppBar(title: 'Favorite'.tr, inMain: false),
      body: Container(
        width: width(context),
        height: height(context),
        child: _loading
            ? loadingDialogForBigPages(context)
            : GetStorageHelper.getToken() == ""
                ? Center(child: Text('Please login first'.tr))
                : _orders.isEmpty
                    ? Center(
                        child: Text(
                            'You dont have any items in your favourites'.tr))
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height(context) * 0.01),
                        child: ListView.builder(
                          itemCount: _orders.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Get.to(
                                () => SalonDetailsScreen(
                                    id: _orders[index].itemId),
                                transition: Transition.zoom,
                              ),
                              child: CardWidgetFav(
                                name: _orders[index].name,
                                image: _orders[index].imageUrl,
                                rate: '0.0',
                                adress: _orders[index].price,
                                function: () {
                                  DbHelper helper = DbHelper();
                                  setState(() {
                                    helper
                                        .delete(_orders[index].itemId)
                                        .then((value) {
                                      _getOrders();
                                    });
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}
