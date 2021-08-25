import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/appBar1.dart';
import 'package:rooj/customeWidget/commenStackPage.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/smallButton.dart';
import 'package:rooj/providerModel/addSalonProvider.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/providerModel/daysProvider.dart';
import 'package:rooj/screens/mainPage/mainPage.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class SecondScreenAddingSalon extends StatefulWidget {
  final String categoryId;
  final String name;
  final String adress;
  final String timeFrom;
  final String timeTo;
  final List<XFile>? images;
  final String place;

  const SecondScreenAddingSalon(
      {Key? key,
      required this.categoryId,
      required this.name,
      required this.adress,
      required this.timeFrom,
      required this.timeTo,
      required this.images,
      required this.place})
      : super(key: key);

  @override
  _SecondScreenAddingSalonState createState() =>
      _SecondScreenAddingSalonState();
}

class _SecondScreenAddingSalonState extends State<SecondScreenAddingSalon> {
  String? category;
  String? categoryId;

  List<String> workers = [];
  List<Branches> branches = [];

  TextEditingController workersController = TextEditingController();
  TextEditingController branchesController = TextEditingController();
  TextEditingController branchesNameController = TextEditingController();

  Future<void> _submit() async {
    bool auth = Provider.of<AddSalonProvider>(context, listen: false).done;
    final myProvider = Provider.of<DaysProvider>(context, listen: false);
    showDaialogLoader(context);
    try {
      auth =
          await Provider.of<AddSalonProvider>(context, listen: false).addSalon(
        name: widget.name,
        adress: widget.adress,
        images: widget.images,
        workes: workers,
        branches: branches,
        days: myProvider.selectedDays,
        place: widget.place,
        availability: 'available',
        startDate: widget.timeFrom,
        endDate: widget.timeTo,
        categotyId: widget.categoryId.toString(),
      );
    } on HttpExeption catch (error) {
      customSnackBar(title: 'خطا', content: "لم تتم الاضافه");
    } catch (error) {
      print(error);
      customSnackBar(title: 'خطا', content: "لم تتم الاضافه");
    } finally {
      if (auth) {
        Get.back();
        customSnackBar(title: 'تم الاضافه', content: "تمت الاضافه بنجاح");
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
  Widget build(BuildContext context) {
    List<DayModel> days =
        Provider.of<DaysProvider>(context, listen: false).days;

    return Scaffold(
      appBar: myAppBar(title: 'اضافة مشغل', inMain: false),
      body: stackWidgetF(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ايام العمل المتاحه',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
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
                                    child: Column(
                                      children: [
                                        selectDayWidget(context, days),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            color: AppColors.mainColor,
                                            child: Text(
                                              '              تم              ',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  category == null
                                      ? "الايام"
                                      : category.toString(),
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
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'العاملين',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
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
                            content: Container(
                              height: height(context) * 0.18,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width(context) * 0.02),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'اسم العامل',
                                      ),
                                      controller: workersController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (workersController.text.length == 0) {
                                        Get.back();
                                      } else {
                                        workers.add(workersController.text);
                                        workersController.clear();
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      color: AppColors.mainColor,
                                      child: Text(
                                        '              تم              ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
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
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              workers.isEmpty
                                  ? "العاملين"
                                  : "تم اضافة ${workers.length} عامل",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey),
                            ),
                          ),
                          Icon(Icons.add, size: 30)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'الفروع',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
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
                            content: Container(
                              height: height(context) * 0.28,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width(context) * 0.02),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'اسم الفرع',
                                      ),
                                      controller: branchesNameController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width(context) * 0.02),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'عنوان الفرع',
                                      ),
                                      controller: branchesController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (branchesController.text.length == 0 ||
                                          branchesNameController.text.length ==
                                              00) {
                                        Get.back();
                                      } else {
                                        branches.add(Branches(
                                            adress: branchesController.text,
                                            name: branchesNameController.text));
                                        branchesController.clear();
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      color: AppColors.mainColor,
                                      child: Text(
                                        '              تم              ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
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
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              branches.isEmpty
                                  ? "عنوانين الفروع"
                                  : "تم اضافة ${branches.length} فرع",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey),
                            ),
                          ),
                          Icon(Icons.add, size: 30)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: smallButton(
                        context: context, title: "اضافه", onTap: _submit),
                  ),
                ],
              ),
            ),
          ),
          context: context),
    );
  }

  Widget selectDayWidget(BuildContext context, List<DayModel> days) {
    final dayProvider = Provider.of<DaysProvider>(context, listen: false);
    return StatefulBuilder(builder: (context, setState) {
      return ListView.builder(
        itemCount: days.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Center(
                    child: Text(
                      days[index].day.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Checkbox(
                    value: days[index].selected,
                    onChanged: (val) {
                      setState(() {
                        days[index].selected = !days[index].selected;
                      });
                      if (days[index].selected) {
                        dayProvider.addToList(days[index].id);
                      } else {
                        dayProvider.removeFromList(days[index].id);
                      }
                    }),
              ],
            ),
          );
        },
      );
    });
  }
}

class Branches {
  final String name;
  final String adress;

  Branches({required this.name, required this.adress});
}
