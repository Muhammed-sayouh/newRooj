import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  DateTime? selectedDateFrom;
  DateTime? selectedDateTo;

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
          timeFrom: selectedDateFrom.toString(),
          timeTo: selectedDateTo.toString(),
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'اضافة صالو', inMain: false),
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
                      'صور الصالون',
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
                        hintText: 'اسم المشغل',
                      ),
                      controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'العنوان'),
                      controller: adress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'وقت الدوام',
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
                          onTap: () => _selectDateFrom(context),
                          child: TimeWidget(
                            text: Center(
                              child: selectedDateFrom == null
                                  ? Text('وقت الابتداء ')
                                  : Text(selectedDateFrom
                                      .toString()
                                      .substring(0, 10)),
                            ),
                          ),
                        ),
                        Text('الي'),
                        InkWell(
                          onTap: () => _selectDateTo(context),
                          child: TimeWidget(
                            text: Center(
                                child: selectedDateTo == null
                                    ? Text('وقت النهايه')
                                    : Text(selectedDateTo
                                        .toString()
                                        .substring(0, 10))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'القسم',
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
                                          ? "القسم"
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
                      'تقديم الخدمه في',
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
                                    ? "المكان"
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
                        title: "اضافه",
                        onTap: subCategory == null ||
                                selectedplace == null ||
                                selectedDateFrom == null ||
                                selectedDateTo == null ||
                                chosenImages == null
                            ? () => customSnackBar(
                                title: 'عفوا',
                                content: 'يرجي اكمال جميع الحقول')
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
