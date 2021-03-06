import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/db/db.dart';
import 'package:rooj/db/orderInfo.dart';
import 'package:rooj/helpers/changeColorForSalonDetails.dart';
import 'package:rooj/helpers/getStorageHelper.dart';
import 'package:rooj/providerModel/daysProvider.dart';
import 'package:rooj/providerModel/removeAndAddfavouriteProvider.dart';
import 'package:rooj/providerModel/salonItemDetailsProvider.dart' as Info;
import 'package:rooj/providerModel/salonServicesProvider.dart';
import 'package:rooj/providerModel/subCategoriesProvider.dart' as Category;
import 'package:rooj/screens/choosetime/chooseTime.dart';
import 'package:rooj/screens/salonDetails/indecator.dart';
import 'package:rooj/screens/viewLocation.dart/viewLocation.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:share/share.dart';

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
  ScrollController _scrollController = new ScrollController();

  int currentIndex = 0;
  int counter = 1;
  String place = 'in_salon';
  bool loaderO = false;
  Info.Data? data = Info.Data(
      isFav: 'false',
      salon: Info.Salon(
          workers: [],
          address: '',
          availability: '',
          averageReview: null,
          branches: [],
          categoryId: 00,
          cityId: 00,
          wallet: '',
          clientId: 00,
          closingTime: '',
          createdAt: DateTime.now(),
          days: null,
          id: 00,
          images: [],
          name: '',
          openingTime: '',
          place: '',
          updatedAt: DateTime.now(),
          views: 0),
      serviceInHome: [],
      servicesInSalon: []);
  List<Category.Datum> subCategories = [];
  List<Datum> services = [];
  List<Datum> felterdservices = [];
  late int catId;
  Future<void> futureO() async {
    Provider.of<SalonServicesProvider>(context, listen: false).newList.clear();
    Provider.of<DaysProvider>(context, listen: false).selectedworkers.clear();
    loaderO = true;
    try {
      data = await Provider.of<Info.SalonItemDetailsProvider>(context,
              listen: false)
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

  Future<void> _submit(int id) async {
    bool auth =
        Provider.of<AddAndRemoveFavProvider>(context, listen: false).done;

    try {
      auth = await Provider.of<AddAndRemoveFavProvider>(context, listen: false)
          .sent(id.toString());
    } catch (error) {
      print(error);

      showErrorDaialog("NoInternet".tr, context);
    }
    // finally {
    //   if (auth) {
    //     futureO()
    //         .then((value) => futureSub())
    //         .then((value) => futureServices(id: subCategories[0].categoryId));
    //   }
    // }
  }

  bool fav = false;
  void isVav() {
    DbHelper helper = DbHelper();
    helper.isexisting(widget.id).then((value) {
      print(value);
      setState(() {
        fav = value;
      });
    });
  }

  bool selectAll = true;
  @override
  void initState() {
    isVav();
    futureO()
        .then((value) => futureSub())
        .then((value) => futureServices(id: subCategories[0].categoryId))
        .then((value) => {felterdservices = services})
        .then(
          (value) => _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.id} real ID');
    final items = Provider.of<ItemForSalonDetails>(context);
    bool selected = false; // default val. of bool
    final myProvider =
        Provider.of<SalonServicesProvider>(context, listen: false);
    print(data!.isFav);
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
                                itemCount: data!.salon!.images.length,
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
                                    data!.salon!.images[itemIndex].imagePath
                                        .toString(),
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
                                name: data!.salon!.name.toString(),
                                rate: data!.salon!.averageReview.toString(),
                                views: data!.salon!.views.toString(),
                                adress: data!.salon!.address.toString(),
                                from: data!.salon!.openingTime.toString(),
                                to: data!.salon!.closingTime.toString(),
                                branches: data!.salon!.branches,
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
                                  child: InkWell(
                                      onTap: () => Get.to(() => ViewLocation(),
                                          transition: Transition.zoom),
                                      child: Image.asset(
                                          'assets/images/map_box.png')),
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
                                            onTap: () async {
                                              Share.share(
                                                  'https://play.google.com/store/');
                                            },
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
                                            onTap: () {
                                              setState(() {});
                                              DbHelper helper = DbHelper();
                                              if (fav) {
                                                helper
                                                    .delete(data!.salon!.id!
                                                        .toInt())
                                                    .then((value) {
                                                  // customSnackBar(
                                                  //     content:
                                                  //         '???? ?????????????? ???? ??????????????',
                                                  //     title: '????');
                                                  setState(() {
                                                    fav = false;
                                                  });
                                                });
                                              } else {
                                                helper
                                                    .createOrder(
                                                        OrderInfo(
                                                            id: data!.salon!.id!
                                                                .toInt(),
                                                            imageUrl: data!
                                                                .salon!
                                                                .images[0]
                                                                .imagePath
                                                                .toString(),
                                                            itemId: data!
                                                                .salon!.id!
                                                                .toInt(),
                                                            name: data!
                                                                .salon!.name
                                                                .toString(),
                                                            price: data!
                                                                .salon!.address
                                                                .toString(),
                                                            saleprice: '',
                                                            quantity: 0),
                                                        counter: counter)
                                                    .then((value) {
                                                  setState(() {
                                                    fav = true;
                                                  });
                                                  // customSnackBar(
                                                  //     content:
                                                  //         '???? ?????????????? ?????? ?????????????? ??????????',
                                                  //     title: '???? ??????????????');
                                                });
                                              }
                                            },
                                            child: SizedBox(
                                              child: fav
                                                  ? Icon(
                                                      CupertinoIcons.heart_fill,
                                                      color:
                                                          AppColors.mainColor,
                                                    )
                                                  : Icon(
                                                      CupertinoIcons.heart,
                                                      color:
                                                          AppColors.mainColor,
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
                                    "inSalonPr".tr,
                                    style: TextStyle(
                                      fontSize: 16,
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
                                      fontSize: 16,
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
                              controller: _scrollController,
                              itemCount: subCategories.length + 1,
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              itemBuilder: (context, index) {
                                if (index == subCategories.length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectAll = true;
                                          felterdservices = services;
                                          items.toggleSelected(5000);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: selectAll
                                              ? AppColors.mainColor
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '  ${"All".tr}  ',
                                            style: TextStyle(
                                              color: selectAll
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: InkWell(
                                      onTap: () {
                                        catId = subCategories[index].categoryId;
                                        // futureServices(
                                        //   id: subCategories[index].categoryId,
                                        // );
                                        felterdservices = services
                                            .where((element) =>
                                                element.subcategoryId ==
                                                subCategories[index].id)
                                            .toList();
                                        setState(() => selected = !selected);
                                        selectAll = false;
                                        items.toggleSelected(index);
                                        if (selected) {
                                          items.setColor(AppColors.mainColor);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: items.selectedIndex == index
                                              ? items.getColor()
                                              : Colors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '  ${subCategories[index].name}  ',
                                            style: TextStyle(
                                              color:
                                                  items.selectedIndex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
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
                                              duration: felterdservices[index]
                                                  .duration
                                                  .toString(),
                                              name: felterdservices[index]
                                                  .name
                                                  .toString(),
                                              offer: felterdservices[index]
                                                          .priceInOffer ==
                                                      00
                                                  ? ''
                                                  : felterdservices[index]
                                                      .priceInOffer
                                                      .toString(),
                                              price: felterdservices[index]
                                                          .price
                                                          .toString() ==
                                                      "00"
                                                  ? ''
                                                  : felterdservices[index]
                                                      .price
                                                      .toString(),
                                              workers: data!.salon!.workers,
                                            ),
                                            GetStorageHelper.getToken() == ""
                                                ? SizedBox()
                                                : InkWell(
                                                    onTap: () {
                                                      felterdservices[index]
                                                              .selected =
                                                          !services[index]
                                                              .selected;
                                                      if (felterdservices[index]
                                                          .selected) {
                                                        myProvider.addToList(
                                                            felterdservices[
                                                                    index]
                                                                .id!
                                                                .toInt());
                                                      } else {
                                                        myProvider
                                                            .removeFromList(
                                                                felterdservices[
                                                                        index]
                                                                    .id!
                                                                    .toInt());
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                        width: width(context) *
                                                            0.2,
                                                        height:
                                                            height(context) *
                                                                0.1,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              felterdservices[
                                                                          index]
                                                                      .selected
                                                                  ? AppColors
                                                                      .mainColor
                                                                  : Colors
                                                                      .white,
                                                          border: Border(
                                                            right: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            felterdservices[
                                                                        index]
                                                                    .selected
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
                                    itemCount: felterdservices.length),
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
                                    InkWell(
                                      onTap: myProvider.getTotal() < 200 &&
                                              place == 'in_home'
                                          ? () => customSnackBar(
                                              title: "sorry".tr,
                                              content:
                                                  "The lowest price for services at home is 200 riyals"
                                                      .tr)
                                          : () => Get.to(
                                                () => ChooseTimeScreen(
                                                  place: place,
                                                  salonId:
                                                      data!.salon!.id!.toInt(),
                                                  adress: data!.salon!.address
                                                      .toString(),
                                                  name: data!.salon!.name
                                                      .toString(),
                                                  image: data!
                                                          .salon!.images.isEmpty
                                                      ? ''
                                                      : '',
                                                ),
                                                transition: Transition.zoom,
                                              ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "book now".tr,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
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
                                        ],
                                      ),
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
