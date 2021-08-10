import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooj/customeWidget/drawer.dart';
import 'package:rooj/helpers/globalState.dart';
import 'package:rooj/screens/Reservations/reservations.dart';
import 'package:rooj/screens/home/home.dart';
import 'package:rooj/screens/offers/offers.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/screens/userProfile/userProfile.dart';
import 'package:rooj/screens/vendorProfile/vendorProfile.dart';
import 'package:rooj/style/sizes.dart';
import 'package:slide_drawer/slide_drawer.dart';

class MainPage extends StatefulWidget {
  final int index;

  MainPage({Key? key, required this.index}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int type = 0;
  int isRent = 0;
  int pageIndex = 3;
  bool showFilter = false;
  List<Widget> pages = [
    GetStorageHelper.userType() == '1'
        ? VendorProfileScreen()
        : UserProfileScreen(),
    OffersScreen(),
    ReservationsScreen(),
    Home(),
  ];

  @override
  void initState() {
    setState(
      () {
        pageIndex = widget.index;
      },
    );
    super.initState();
  }

  void _pageChanged(int page) {
    setState(
      () {
        pageIndex = page;
      },
    );
  }

  final _pageController = PageController(
      initialPage: GlobalState.instance.get('selectedPage') != null
          ? GlobalState.instance.get('selectedPage')
          : 0);

  void navigationTapped(int page) {
    GlobalState.instance.set('selectedPage', null);
    setState(() {
      pageIndex = page;
      // _selectedPage = page;
    });
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 10),
        curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: SlideDrawer(
        isRotate: true,
        offsetFromRight: Get.locale!.languageCode == 'ar'
            ? width(context) * 1.45
            : width(context) * 0.3,
        drawer: MyDrawer(),
        child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: _pageChanged,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[pageIndex];
                  }),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: height(context) * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            navigationTapped(0);
                          },
                          child: Container(
                            width: height(context) * 0.075,
                            child: pageIndex == 0
                                ? SizedBox()
                                : Image.asset(
                                    'assets/images/user_off.png',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigationTapped(1);
                          },
                          child: Container(
                            width: height(context) * 0.075,
                            child: pageIndex == 1
                                ? SizedBox()
                                : Image.asset(
                                    'assets/images/offers_off.png',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigationTapped(2);
                          },
                          child: Container(
                            width: height(context) * 0.075,
                            child: pageIndex == 2
                                ? SizedBox()
                                : Image.asset(
                                    'assets/images/calender_off.png',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigationTapped(3);
                          },
                          child: Container(
                            width: height(context) * 0.075,
                            child: pageIndex == 3
                                ? SizedBox()
                                : Image.asset(
                                    'assets/images/home_off.png',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context) * 0.85,
                left: width(context) * 0.04,
                child: Offstage(
                  offstage: pageIndex == 0 ? false : true,
                  child: SizedBox(
                    height: 85,
                    width: 60,
                    child: Image.asset(
                      'assets/images/user_on.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context) * 0.85,
                left: width(context) * 0.29,
                child: Offstage(
                  offstage: pageIndex == 1 ? false : true,
                  child: SizedBox(
                    height: 85,
                    width: 60,
                    child: Image.asset(
                      'assets/images/offers_on.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context) * 0.85,
                left: width(context) * 0.54,
                child: Offstage(
                  offstage: pageIndex == 2 ? false : true,
                  child: SizedBox(
                    height: 85,
                    width: 60,
                    child: Image.asset(
                      'assets/images/calender_on.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context) * 0.85,
                left: width(context) * 0.79,
                child: Offstage(
                  offstage: pageIndex == 3 ? false : true,
                  child: SizedBox(
                    height: 85,
                    width: 60,
                    child: Image.asset(
                      'assets/images/home_on.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
