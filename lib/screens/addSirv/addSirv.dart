import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/addOfferProvider.dart';
import 'package:rooj/providerModel/addSirvProvider.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/providerModel/subCategoriesProvider.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';
import 'package:rooj/providerModel/subCategoriesProvider.dart' as Category;
import 'package:rooj/providerModel/vendorProfileInfo.dart' as Profile;

class AddSirvScreen extends StatefulWidget {
  @override
  _AddSirvScreenState createState() => _AddSirvScreenState();
}

class _AddSirvScreenState extends State<AddSirvScreen> {
  List<XFile>? chosenImages;
  dynamic _pickImageError;

  DateTime? selectedDateFrom;
  DateTime? selectedDateTo;

  List<Place> place = [
    Place("in home".tr, 'in_home'),
    Place("in salon".tr, 'both'),
    Place('both'.tr, 'both')
  ];

  int? id;
  bool loaderO = false;
  List<Category.Datum> subCategories = [];
  Profile.Provider? _provider;
  Future<void> futureO() async {
    setState(() {
      loaderO = true;
    });

    try {
      await Provider.of<Profile.GetProviderProfile>(context, listen: false)
          .fetchProvider();
      _provider =
          Provider.of<Profile.GetProviderProfile>(context, listen: false)
              .provider;

      for (var i = 0; i < _provider!.salon.length; i++) {
        id = _provider!.salon[i].id;
      }
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

  String? selectedplace;
  String? placeId;

  String? subCategory;
  String? subCategoryId;

  String? selectedName;
  String? nameId;

  List<Service> services = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController duration = TextEditingController();
  TextEditingController details = TextEditingController();

  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateFrom = picked;
      });
  }

  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateTo = picked;
      });
  }

  Future<void> picImages() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final List<XFile>? images = await _picker.pickMultiImage();

      setState(() {
        chosenImages = images;
      });
    } catch (e) {
      chosenImages = _pickImageError;
    }
  }

  Future<void> _submit() async {
    bool auth = Provider.of<AddOfferProvider>(context, listen: false).done;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showDaialogLoader(context);
    try {
      auth = await Provider.of<AddSirvProvider>(context, listen: false).signIn(
        name: selectedName == null || selectedName!.isEmpty
            ? ''
            : selectedName.toString(),
        price: price.text,
        place: placeId.toString(),
        details:
            details.text.isEmpty ? 'لا يوجد تفاصيل' : details.text.toString(),
        categotyId: subCategoryId.toString(),
        // images: chosenImages,
        salonId: id.toString(),
        duration: '',
      );
    } on HttpExeption catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("NoInternet".tr, context);
    } catch (error) {
      print(error);
      Navigator.of(context).pop();
      showErrorDaialog("NoInternet".tr, context);
    } finally {
      if (auth) {
        Get.back();
        customSnackBar(title: "success".tr, content: "Successfully added".tr);
        Future.delayed(Duration(seconds: 1)).then(
          (value) => Get.offAll(
            () => MainPage(index: 3),
            transition: Transition.zoom,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    futureSub();
    futureO();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "Add Service".tr, inMain: false),
      body: stackWidgetF(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Service Pictures".tr,
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // Divider(
                    //   thickness: 1,
                    // ),
                    // Row(
                    //   children: [
                    //     chosenImages == null
                    //         ? SizedBox()
                    //         : Container(
                    //             width: width(context) * 0.7,
                    //             height: height(context) * 0.1,
                    //             child: ListView.builder(
                    //               scrollDirection: Axis.horizontal,
                    //               itemCount: chosenImages!.length,
                    //               itemBuilder: (context, index) {
                    //                 return Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 5),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     child: Container(
                    //                       width: width(context) * 0.2,
                    //                       height: width(context) * 0.1,
                    //                       child: ClipRRect(
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                         child: Image.file(
                    //                           File(chosenImages![index].path),
                    //                           fit: BoxFit.fill,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //     InkWell(
                    //       onTap: picImages,
                    //       child: Icon(
                    //         Icons.camera_alt,
                    //         color: AppColors.mainColor,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Service type".tr,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    loaderO
                        ? Center(child: CupertinoActivityIndicator())
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 17, vertical: 10),
                            width: width(context),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.mainColor),
                            ),
                            child: InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.backGroundColor,
                                    content: Center(
                                      child: Container(
                                        child: supCategoryWidget(
                                            context, subCategories),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          20,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ), //_modalBottomSheetMenu(context, cities),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      subCategory == null
                                          ? "Type".tr
                                          : subCategory.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, size: 30)
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                      width: width(context),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.backGroundColor,
                              content: Center(
                                child: Container(
                                  child: subCategoriesNamesWidget(
                                      context, services),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ), //_modalBottomSheetMenu(context, cities),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedName == null
                                    ? "Offer name".tr
                                    : selectedName.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.grey),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 30)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "price".tr),
                      controller: price,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Thisfieldisrequired".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextFormFieldWithPerfix(
                      hint: "Duration".tr,
                      obscureText: false,
                      suffix: "Minute".tr,
                      controller: duration,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Thisfieldisrequired".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Service place".tr,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                      width: width(context),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.backGroundColor,
                              content: Center(
                                child: Container(
                                  child: citiesWidget(context, place),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ), //_modalBottomSheetMenu(context, cities),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedplace == null
                                    ? "place".tr
                                    : selectedplace.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.grey),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 30)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Another Details".tr,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Details".tr),
                      controller: details,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                        child: smallButton(
                            context: context,
                            title: "add".tr,
                            onTap: subCategory == null || selectedplace == null
                                ? () => customSnackBar(
                                    title: "sorry".tr,
                                    content: "Please complete all fields".tr)
                                : _submit)),
                    SizedBox(
                      height: 35,
                    )
                  ],
                ),
              ),
            ),
          ),
          context: context),
    );
  }

  Widget citiesWidget(BuildContext context, List<Place> place) {
    return ListView.builder(
      itemCount: place.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedplace = place[index].name;
              placeId = place[index].value;
            });
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Offstage(
                    offstage: selectedplace == place[index].name ? false : true,
                    child:
                        Icon(Icons.check_circle, color: AppColors.mainColor)),
                // SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: Text(
                        place[index].name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget subCategoriesNamesWidget(
      BuildContext context, List<Service> services) {
    return services.length == 0
        ? Text(
            'لا يوجد خدمات',
            style: TextStyle(color: AppColors.mainColor),
          )
        : ListView.builder(
            itemCount: services.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedName = services[index].name;
                    nameId = services[index].id.toString();
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Offstage(
                          offstage: selectedName == services[index].name
                              ? false
                              : true,
                          child: Icon(Icons.check_circle,
                              color: AppColors.mainColor)),
                      // SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Center(
                            child: Text(
                              services[index].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget supCategoryWidget(
      BuildContext context, List<Category.Datum> subCategories) {
    return ListView.builder(
      itemCount: subCategories.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              subCategory = subCategories[index].name;
              subCategoryId = subCategories[index].id.toString();
              services = subCategories[index].services;
            });
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Offstage(
                    offstage:
                        subCategory == subCategories[index].name ? false : true,
                    child:
                        Icon(Icons.check_circle, color: AppColors.mainColor)),
                // SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: Text(
                        subCategories[index].name.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TimeWidget extends StatelessWidget {
  final Widget text;

  const TimeWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.35,
      height: height(context) * 0.065,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.mainColor)),
      child: text,
    );
  }
}

class Place {
  final String name;
  final String value;

  Place(this.name, this.value);
}
