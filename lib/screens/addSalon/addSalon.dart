import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/homeProvider.dart';
import 'package:rooj/screens/addSalon/secondScreen.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';
import 'package:get/get.dart';

class AddSalonScreen extends StatefulWidget {
  @override
  _AddSalonScreenState createState() => _AddSalonScreenState();
}

class _AddSalonScreenState extends State<AddSalonScreen> {
  List<XFile>? chosenImages;
  dynamic _pickImageError;

  List<Place> place = [
    Place("in home".tr, 'in_home'),
    Place("in salon".tr, 'in_salon'),
    Place('both'.tr, 'both')
  ];

  bool loaderO = false;
  List<Datum> homeItems = [];
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

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Get.to(
      () => SecondScreenAddingSalon(
          categoryId: subCategoryId.toString(),
          name: name.text,
          adress: adress.text,
          timeFrom: DateFormat("hh:mma").format(selectedTimeFrom),
          timeTo: DateFormat("hh:mma").format(selectedTimeTo),
          images: chosenImages,
          place: placeId.toString()),
      transition: Transition.zoom,
    );
  }

  @override
  void initState() {
    futureO();
    super.initState();
  }

  String? selectedplace;
  String? placeId;

  String? subCategory;
  String? subCategoryId;

  DateTime selectedTimeFrom = DateTime.now();
  DateTime selectedTimeTo = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();

  fromTime() async {
    TimeOfDay time = TimeOfDay.now();
    final now = new DateTime.now();
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (picked != null && picked != time) {
      setState(() {
        // add this line.
        DateTime pickedToDate =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        selectedTimeFrom = pickedToDate;
        time = picked;
      });
    }
  }

  toTime() async {
    TimeOfDay time = TimeOfDay.now();
    final now = new DateTime.now();
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (picked != null && picked != time) {
      setState(() {
        DateTime pickedToDate =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        selectedTimeTo = pickedToDate;
        time = picked;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "Add salon".tr, inMain: false),
      body: stackWidgetF(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Salon Pictures".tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        chosenImages == null
                            ? SizedBox()
                            : Container(
                                width: width(context) * 0.7,
                                height: height(context) * 0.1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: chosenImages!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: width(context) * 0.2,
                                          height: width(context) * 0.1,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(chosenImages![index].path),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        InkWell(
                          onTap: picImages,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Salon name".tr,
                      ),
                      controller: name,
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
                    TextFormField(
                      decoration: InputDecoration(hintText: "adress".tr),
                      controller: adress,
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
                      "Working time".tr,
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => fromTime(),
                          child: TimeWidget(
                            text: Center(
                              child: selectedTimeFrom == null
                                  ? Text("Start time".tr)
                                  : Text(DateFormat("hh:mma")
                                      .format(selectedTimeFrom)),
                            ),
                          ),
                        ),
                        Text('To'.tr),
                        InkWell(
                          onTap: () => toTime(),
                          child: TimeWidget(
                            text: Center(
                                child: selectedTimeTo == null
                                    ? Text("End Time".tr)
                                    : Text(DateFormat("hh:mma")
                                        .format(selectedTimeTo))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Category".tr,
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
                                            context, homeItems),
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
                                          ? "Category".tr
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
                    Center(
                      child: smallButton(
                        context: context,
                        title: "next".tr,
                        onTap: subCategory == null ||
                                selectedplace == null ||
                                selectedTimeFrom == null ||
                                selectedTimeTo == null ||
                                chosenImages == null
                            ? () => customSnackBar(
                                title: "sorry".tr,
                                content: "Please complete all fields".tr)
                            : _submit,
                      ),
                    ),
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

  Widget supCategoryWidget(BuildContext context, List<Datum> homeItems) {
    return ListView.builder(
      itemCount: homeItems.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              subCategory = homeItems[index].name;
              subCategoryId = homeItems[index].id.toString();
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
                        subCategory == homeItems[index].name ? false : true,
                    child:
                        Icon(Icons.check_circle, color: AppColors.mainColor)),
                // SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: Text(
                        homeItems[index].name.toString(),
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
