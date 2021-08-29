import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/helpers/changeColorProvider.dart';
import 'package:rooj/providerModel/offersProvider.dart';
import 'package:rooj/screens/salonDetails/salonDetails.dart';
import 'package:rooj/style/colors.dart';
import 'package:get/get.dart';
import 'package:rooj/style/sizes.dart';
import 'package:rooj/providerModel/homeProvider.dart';

import 'offerCardWidget.dart';

class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  TextEditingController search = TextEditingController();
  int selectedPage = 1;
  bool loaderO = false;
  List<Datum> homeItems = [];
  List<DatumOffers> offers = [];
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      homeItems =
          await Provider.of<HomeProvider>(context, listen: false).fetchHome();
      setState(() {
        loaderO = false;
      });
    } catch (error) {
      setState(() {
        loaderO = false;
      });
      throw (error);
    }
  }

  Future<void> futureB(int id) async {
    setState(() {
      loaderO = true;
    });

    try {
      offers = await Provider.of<OffersProvider>(context, listen: false)
          .fetchOffers(id);
      setState(() {
        loaderO = false;
      });
    } catch (error) {
      setState(() {
        loaderO = false;
      });
      throw (error);
    }
  }

  @override
  void initState() {
    futureO().then((value) => futureB(homeItems[0].id.toInt()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<Item>(context);
    bool selected = false; // default val. of bool
    return Scaffold(
      backgroundColor: AppColors.mainBackGroundColor,
      appBar: myAppBar(title: "offers".tr, inMain: true),
      body: stackWidgetFullPage(
          body: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width(context) * 0.025),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0),
                        spreadRadius: 10,
                        blurRadius: 3,
                        offset: Offset(4, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: MyTextFormFieldWithImage(
                    obscureText: false,
                    hint: "HomeSearch".tr,
                    image: 'assets/images/search_icon.png',
                    controller: search,
                  ),
                ),
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              Container(
                width: width(context),
                height: height(context) * 0.07,
                child: ListView.builder(
                  itemCount: homeItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    print(homeItems.length);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          futureB(homeItems[index].id.toInt());
                          setState(() => selected = !selected);
                          items.toggleSelected(index);
                          if (selected) {
                            items.setColor(AppColors.mainColor);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: items.selectedIndex == index
                                ? items.getColor()
                                : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              '  ${homeItems[index].name}  ',
                              style: TextStyle(
                                color: items.selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              loaderO
                  ? loadingDialogForSmallestPages(context)
                  : offers.isEmpty
                      ? Center(
                          child: Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: height(context) * 0.2),
                              child: Text(
                                'There are no offers in this section'.tr,
                                style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print(offers[index].id);
                                Get.to(
                                    SalonDetailsScreen(
                                        id: offers[index].salonId),
                                    transition: Transition.zoom);
                              },
                              child: OfferCardWidget(
                                image: '',
                                name: offers[index].name,
                                percentage: offers[index].percentage.toString(),
                              ),
                            );
                          },
                        ))
            ],
          ),
          context: context),
    );
  }
}
