import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rooj/customeWidget/buttons.dart';
import 'package:rooj/customeWidget/cardWidget.dart';
import 'package:rooj/customeWidget/dialogs.dart';
import 'package:rooj/customeWidget/myTextFormField.dart';
import 'package:rooj/customeWidget/wavy_header_image.dart';
import 'package:rooj/providerModel/auth.dart';
import 'package:rooj/providerModel/vendorProfileInfo.dart' as Profile;
import 'package:rooj/screens/addSirv/addSirv.dart';
import 'package:rooj/screens/vendorProfile/rowWidget/rowWidget.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class VendorProfileScreen extends StatefulWidget {
  @override
  _VendorProfileScreenState createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController identy = TextEditingController();
  TextEditingController insta = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Profile.Provider? _provider;
  bool loader = false;

  List<Profile.Offer> offers = [];
  int offerLenth = 0;
  int sirvLenth = 0;
  XFile? chosenImages;
  XFile? _pickImageError;
  Future<void> picImages() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        chosenImages = image;
      });
    } catch (e) {
      chosenImages = _pickImageError;
    }
  }

  Future<void> futureO() async {
    setState(() {
      loader = true;
    });

    try {
      await Provider.of<Profile.GetProviderProfile>(context, listen: false)
          .fetchProvider();

      _provider =
          Provider.of<Profile.GetProviderProfile>(context, listen: false)
              .provider;

      name.text = _provider!.name;
      phone.text = _provider!.phone;
      email.text = _provider!.email;
      identy.text = _provider!.identityNumber;
      insta.text = _provider!.instagram;

      for (var i = 0; i < _provider!.salon.length; i++) {
        sirvLenth = _provider!.salon[i].services.length;
        print(_provider!.salon[i].offers.length);
        print(_provider!.salon[i].services.length);
      }
      for (var i = 0; i < _provider!.salon[i].offers.length; i++) {
        if (_provider!.salon[i].offers.isEmpty) {
          offerLenth = 0;
          offers = [];
        } else {
          offerLenth = _provider!.salon[i].offers.length;
          offers = _provider!.salon[i].offers;
        }
      }

      setState(() {
        loader = false;
      });
    } catch (error) {
      setState(() {
        loader = false;
      });
      throw (error);
    }
  }

  Future<void> _submit() async {
    bool auth =
        Provider.of<Auth>(context, listen: false).doneEdaitVendorProfile;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      loader = true;
    });
    try {
      auth = await Provider.of<Auth>(context, listen: false)
          .updateVendorProfile(
              name.text, phone.text, identy.text, insta.text, chosenImages);
    } on HttpExeption catch (error) {
      print(error);
      setState(() {
        loader = false;
      });
      showErrorDaialog("NoInternet".tr, context);
    } catch (error) {
      print(error);
      setState(() {
        loader = false;
      });
      showErrorDaialog("NoInternet".tr, context);
    } finally {
      if (auth) {
        futureO().then(
            (value) => customSnackBar(title: "ok".tr, content: "doneEdait".tr));
      }
    }
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    futureO();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_icons.png'),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: loader
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: height(context) * 0.48),
                    child: SpinKitHourGlass(
                      color: AppColors.mainColor,
                      size: 25,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        Stack(
                          children: [
                            WavyHeaderImage(
                              image: _provider!.image.toString(),
                            ),
                            Positioned(
                              bottom: width(context) * 0.18,
                              left: width(context) * 0.015,
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: _profilePicture()),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.04),
                      child: loader
                          ? loadingDialogForSmallestPages(context)
                          : Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Text(
                                    'تعديل حسابي',
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.05,
                                  ),
                                  MyTextFormFieldWithImage(
                                    obscureText: false,
                                    controller: name,
                                    hint: 'الاسم',
                                    image: 'assets/images/user_off.png',
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
                                  MyTextFormFieldWithImage(
                                    obscureText: false,
                                    controller: phone,
                                    hint: 'رقم الجوال',
                                    image: 'assets/images/smart_phone_line.png',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Thisfieldisrequired".tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // MyTextFormFieldWithImageAndPerfix(
                                  //   obscureText: true,
                                  //   controller: password,
                                  //   hint: 'الرقم السري',
                                  //   image: 'assets/images/lock_line.png',
                                  //   suffix: 'تغيير',
                                  //   validator: (value) {
                                  //     if (value!.isEmpty) {
                                  //       return "Thisfieldisrequired".tr;
                                  //     } else {
                                  //       return null;
                                  //     }
                                  //   },
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MyTextFormFieldWithImage(
                                    obscureText: false,
                                    controller: identy,
                                    hint: 'رقم الهوية او السجل التجارى',
                                    image: 'assets/images/smart_phone_line.png',
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
                                  MyTextFormFieldWithImage(
                                    obscureText: false,
                                    controller: email,
                                    hint: 'الايميل',
                                    image: 'assets/images/message.png',
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
                                  MyTextFormFieldWithImage(
                                    obscureText: false,
                                    controller: insta,
                                    hint: 'الانستقرام',
                                    image: 'assets/images/instegram_line.png',
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
                                  Row(
                                    children: [
                                      Container(
                                        width: 33,
                                        height: 33,
                                        margin: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.textFieldIconBackColor,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: Image.asset(
                                              "assets/images/image_placeholder.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: picImages,
                                        child: Column(
                                          children: [
                                            Text(
                                              "ارفاق شهاده",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "اختياري",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      chosenImages == null
                                          ? SizedBox()
                                          : SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  File(
                                                    chosenImages!.path,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: _submit,
                      child: saveButton(
                          title: 'حفظ', image: 'assets/images/next_circle.png'),
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(context) * 0.02),
                          child: Text(
                            'المشاغل',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(context) * 0.02),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Container(
                            height: 260,
                            width: width(context),
                            child: ListView.builder(
                              itemCount: _provider!.salon.length,
                              itemBuilder: (context, index) {
                                return CardWidgetForVendorProfile(
                                  adress: _provider!.salon[index].address,
                                  desc: _provider!.salon[index].city,
                                  title: _provider!.salon[index].name,
                                  image: _provider!.salon[index].image.isEmpty
                                      ? ''
                                      : _provider!
                                          .salon[index].image[0].imagePath,
                                );
                              },
                            ))
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(context) * 0.02),
                          child: Text(
                            'العروض',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width(context) * 0.02),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Container(
                          height: 260,
                          width: width(context),
                          child: ListView.builder(
                            itemCount: offerLenth,
                            itemBuilder: (context, index) {
                              return CardWidgetForVendorProfile(
                                adress: offers[index].salonAddress,
                                desc:
                                    '${offers[index].percentage.toString()} %',
                                title: offers[index].name,
                                image: offers[index].image.isEmpty
                                    ? ''
                                    : offers[index].image[0].imagePath,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        // rowWidget(
                        //   context: context,
                        //   title: 'الفروع',
                        //   addString: "اضف فرع",
                        // ),
                        // SizedBox(
                        //   height: height(context) * 0.05,
                        // ),
                        InkWell(
                          onTap: () => Get.to(
                            () => AddSirvScreen(),
                            transition: Transition.zoom,
                          ),
                          child: rowWidget(
                            context: context,
                            title: 'الخدمات',
                            addString: "اضف خدمه",
                          ),
                        ),
                        Container(
                          height: 260,
                          width: width(context),
                          child: ListView.builder(
                            itemCount: sirvLenth,
                            itemBuilder: (context, index) {
                              return CardWidgetForVendorProfile(
                                adress: '',
                                desc: '',
                                title: _provider!
                                    .salon[index].services[index].name,
                                image: _provider!.salon[index].services[index]
                                        .image.isEmpty
                                    ? ''
                                    : _provider!.salon[index].services[index]
                                        .image[0].imagePath,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.15,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

Widget _profilePicture() {
  return InkWell(
    onTap: () {},
    child: SizedBox(
      height: 150,
      width: 150,
      child: Image.asset(
        'assets/images/profile_circle_white.png',
        fit: BoxFit.fill,
      ),
    ),
  );
}
