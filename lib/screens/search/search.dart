import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/cardWidget.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/searchProvider.dart';
import 'package:rooj/screens/confirmBooking/confirBooking.dart';
import 'package:rooj/screens/map/map.dart';
import 'package:rooj/screens/salonDetails/salonDetails.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  TextEditingController map = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String type = 'salon_name';
  double? lat;
  double? lng;

  bool loaderO = false;
  List<Datum> searchItems = [];
  Future<void> futureO() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      searchItems =
          await Provider.of<SearchProvider>(context, listen: false).fetchSearch(
        lat: lat.toString(),
        long: lng.toString(),
        type: type,
        search: search.text,
      );
      setState(() {});
      Get.back();
    } catch (error) {
      print(error);
      Get.back();
      print(error);

      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "Search".tr, inMain: false),
      body: stackWidget(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = 'salon_name';
                        });
                      },
                      child: Container(
                        width: width(context) * 0.4,
                        height: height(context) * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                                color: type == 'salon_name'
                                    ? AppColors.mainColor
                                    : Colors.white,
                                width: 2.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Service Provider Search".tr,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = 'service_name';
                        });
                      },
                      child: Container(
                        width: width(context) * 0.4,
                        height: height(context) * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                                color: type == 'service_name'
                                    ? AppColors.mainColor
                                    : Colors.white,
                                width: 2.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Search by service name".tr,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search by service name or provider'.tr,
                    ),
                    controller: search,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Thisfieldisrequired".tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push<LocationModel>(
                        PageRouteBuilder(pageBuilder: (_, __, ___) {
                      return PickLocation();
                    })).then((location) {
                      lat = location!.lat;
                      lng = location.lng;

                      setState(() {});
                    });
                  },
                  child: MyTextFormFieldWithImageClicable(
                      hint: lat == null
                          ? "select my location".tr
                          : "your location has been selected".tr,
                      obscureText: false,
                      image: 'assets/images/marker_line.png',
                      controller: map),
                ),
                SizedBox(
                  height: 20,
                ),
                smallButton(context: context, title: 'بحث', onTap: futureO),
                SizedBox(
                  height: 30,
                ),
                loaderO
                    ? loadingDialogForSmallPages(context)
                    : searchItems.isEmpty
                        ? Text(
                            'There are no results for this search'.tr,
                            style: TextStyle(
                                color: AppColors.mainColor, fontSize: 16),
                          )
                        : Expanded(
                            child: ListView.builder(
                            itemCount: searchItems.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.to(
                                  () => SalonDetailsScreen(
                                      id: searchItems[index].id!.toInt()),
                                  transition: Transition.zoom,
                                ),
                                child: CardWidget(
                                  name: searchItems[index].name.toString(),
                                  image: '',
                                  rate: searchItems[index].averageReview,
                                  adress: searchItems[index].address.toString(),
                                ),
                              );
                            },
                          ))
              ],
            ),
          ),
          context: context),
    );
  }
}
