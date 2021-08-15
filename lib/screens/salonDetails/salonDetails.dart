import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/helpers/changeColorForSalonDetails.dart';
import 'package:rooj/providerModel/salonItemDetailsProvider.dart';
import 'package:rooj/providerModel/salonServicesProvider.dart';
import 'package:rooj/providerModel/subCategoriesProvider.dart' as Category;
import 'package:rooj/screens/choosetime/chooseTime.dart';
import 'package:rooj/screens/salonDetails/indecator.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

import 'infoWidget.dart';
import 'itemInfoWidget.dart';

class SalonDetailsScreen extends StatefulWidget {
  final int id;

  const SalonDetailsScreen({Key? key, required this.id}) : super(key: key);
  @override
  _SalonDetailsScreenState createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  List<String> images = [
    'https://s2.best-wallpaper.net/wallpaper/1280x800/1111/Vector-woman-pink-stylish_1280x800.jpg',
    'https://media.istockphoto.com/photos/beautiful-african-american-model-picture-id911119588?k=6&m=911119588&s=612x612&w=0&h=mE6fnfqz3yfK7BLnY1rwUgNn7Mvm3ywclKVDSbS54a4=',
  ];

  int currentIndex = 0;
  String place = 'in_home';
  bool loaderO = false;
  late Data data;
  List<Category.Datum> subCategories = [];
  List<Datum> services = [];
  late int catId;
  Future<void> futureO() async {
    Provider.of<SalonServicesProvider>(context, listen: false).newList.clear();
    loaderO = true;
    try {
      data = await Provider.of<SalonItemDetailsProvider>(context, listen: false)
          .fetchSalonItemDetails(widget.id);

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

  Future<void> futureSub() async {
    loaderO = true;

    try {
      subCategories = await Provider.of<Category.SubCategoriesProvider>(context,
              listen: false)
          .fetchSubCategories();
      catId = subCategories[0].categoryId;

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

  bool loaderS = false;

  Future<void> futureServices({int? id}) async {
    loaderS = true;

    try {
      await Provider.of<SalonServicesProvider>(context, listen: false)
          .fetchSalonServicesProvider(
        salonId: widget.id,
        place: place,
        subcategory: id.toString(),
      );
      services =
          Provider.of<SalonServicesProvider>(context, listen: false).myList;

      setState(() {
        loaderS = false;
      });
    } catch (error) {
      setState(() {
        loaderS = false;
      });
      throw (error);
    }
  }

  @override
  void initState() {
    futureO()
        .then((value) => futureSub())
        .then((value) => futureServices(id: subCategories[0].categoryId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemForSalonDetails>(context);
    bool selected = false; // default val. of bool
    final myProvider =
        Provider.of<SalonServicesProvider>(context, listen: false);
    return Scaffold(
      body: Container(
          color: AppColors.mainBackGroundColor,
          width: width(context),
          height: height(context),
          child: loaderO
              ? loadingDialogForPages(context)
              : Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: height(context) * 0.45,
                          child: Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount: images.length,
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) =>
                                    ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomRight:
                                        Get.locale!.languageCode == 'en'
                                            ? Radius.circular(0)
                                            : Radius.circular(200),
                                    bottomLeft: Get.locale!.languageCode == 'en'
                                        ? Radius.circular(200)
                                        : Radius.circular(0),
                                  ),
                                  child: Image.network(
                                    images[itemIndex],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                options: CarouselOptions(
                                  height: height(context) * 0.33,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  viewportFraction: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height(context) * 0.23,
                                    left: Get.locale!.languageCode == 'en'
                                        ? 0
                                        : width(context) * 0.6,
                                    right: Get.locale!.languageCode == 'en'
                                        ? width(context) * 0.6
                                        : 0),
                                child: Indecator(
                                    imageList: images,
                                    currentIndex: currentIndex),
                              ),
                              InfoWidget(
                                name: data.salon.name,
                                rate: data.salon.averageReview,
                                views: data.salon.views.toString(),
                                adress: data.salon.address,
                                from: data.salon.openingTime,
                                to: data.salon.closingTime,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: height(context) * 0.302,
                                  right: Get.locale!.languageCode == 'ar'
                                      ? width(context) * 0.73
                                      : 0,
                                  left: Get.locale!.languageCode == 'en'
                                      ? width(context) * 0.73
                                      : 0,
                                ),
                                child: SizedBox(
                                  width: 45,
                                  child:
                                      Image.asset('assets/images/map_box.png'),
                                ),
                              ),
                              Container(
                                width: width(context),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height(context) * 0.05,
                                      horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          CupertinoIcons.back,
                                          color: AppColors.mainColor,
                                          size: 35,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: SizedBox(
                                              child: Icon(
                                                Icons.share,
                                                color: AppColors.mainColor,
                                              ),
                                              width: 25,
                                              height: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: SizedBox(
                                              child: Image.asset(
                                                'assets/images/notification_without_dot.png',
                                                color: AppColors.mainColor,
                                              ),
                                              width: 25,
                                              height: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  place = 'in_home';
                                });
                                futureServices(id: catId);
                              },
                              child: Container(
                                width: width(context) * 0.5,
                                height: height(context) * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: place == 'in_home'
                                            ? AppColors.mainColor
                                            : Colors.white,
                                        width: 2.5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "in home".tr,
                                    style: TextStyle(
                                      fontSize: 18,
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
                                  place = 'in_salon';
                                });
                                futureServices(id: catId);
                              },
                              child: Container(
                                width: width(context) * 0.5,
                                height: height(context) * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: place == 'in_salon'
                                            ? AppColors.mainColor
                                            : Colors.white,
                                        width: 2.5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "in salon".tr,
                                    style: TextStyle(
                                      fontSize: 18,
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
                        Container(
                          width: width(context),
                          height: height(context) * 0.07,
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: subCategories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      catId = subCategories[index].categoryId;
                                      futureServices(
                                        id: subCategories[index].categoryId,
                                      );

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
                                          '  ${subCategories[index].name}  ',
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        loaderS
                            ? Center(
                                child: Padding(
                                padding:
                                    EdgeInsets.only(top: height(context) * 0.1),
                                child: CupertinoActivityIndicator(),
                              ))
                            : Expanded(
                                // height: height(context)*0.3,
                                child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: width(context),
                                        height: height(context) * 0.1,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            ItemInfoWidget(
                                              index: index,
                                              duration: services[index]
                                                  .duration
                                                  .toString(),
                                              name: services[index]
                                                  .name
                                                  .toString(),
                                              offer: services[index]
                                                          .priceInOffer ==
                                                      00
                                                  ? ''
                                                  : services[index]
                                                      .priceInOffer
                                                      .toString(),
                                              price: services[index]
                                                          .price
                                                          .toString() ==
                                                      "00"
                                                  ? ''
                                                  : services[index]
                                                      .price
                                                      .toString(),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                services[index].selected =
                                                    !services[index].selected;
                                                if (services[index].selected) {
                                                  myProvider.addToList(
                                                      services[index]
                                                          .id!
                                                          .toInt());
                                                } else {
                                                  myProvider.removeFromList(
                                                      services[index]
                                                          .id!
                                                          .toInt());
                                                }
                                                setState(() {});
                                              },
                                              child: Container(
                                                  width: width(context) * 0.2,
                                                  height: height(context) * 0.1,
                                                  decoration: BoxDecoration(
                                                    color: services[index]
                                                            .selected
                                                        ? AppColors.mainColor
                                                        : Colors.white,
                                                    border: Border(
                                                      right: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      services[index].selected
                                                          ? Icons.check
                                                          : Icons.add,
                                                      size: 40,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: services.length),
                              ),
                        myProvider.getTotal() == 0
                            ? SizedBox()
                            : SizedBox(height: height(context) * 0.1)
                      ],
                    ),
                    myProvider.getTotal() == 0
                        ? SizedBox()
                        : Directionality(
                            textDirection: TextDirection.rtl,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                width: width(context),
                                height: height(context) * 0.09,
                                color: AppColors.mainColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: height(context) * 0.06,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 17),
                                        child: Text(
                                          '  ${myProvider.newList.length} ${"services".tr}  ${myProvider.getTotal()} ${"Rial".tr}  ',
                                          textDirection:
                                              Get.locale!.languageCode == 'ar'
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                        ),
                                      )),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "book now".tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () => Get.to(
                                            () => ChooseTimeScreen(),
                                            transition: Transition.zoom,
                                          ),
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                                child:
                                                    Icon(Icons.arrow_forward)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                )),
    );
  }
}
