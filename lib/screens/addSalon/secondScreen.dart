import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
//  Future<void> _submit() async {
//     bool auth = Provider.of<AddOfferProvider>(context, listen: false).done;
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     showDaialogLoader(context);
//     try {
//       auth = await Provider.of<AddOfferProvider>(context, listen: false).signIn(
//         name: name.text,
//         price: price.text,
//         place: placeId.toString(),
//         details: details.text.toString(),
//         priceInService: offerPrice.text,
//         percentage: percatnage.text.toString(),
//         serviceStartDate: selectedDateFrom.toString().substring(0, 10),
//         serviceEndDate: selectedDateTo.toString().substring(0, 10),
//         categotyId: subCategoryId.toString(),
//         images: chosenImages,
//       );
//     } on HttpExeption catch (error) {
//       print(error);
//       Navigator.of(context).pop();
//       showErrorDaialog("تحقق من الاتصال بالانترنت", context);
//     } catch (error) {
//       print(error);
//       Navigator.of(context).pop();
//       showErrorDaialog("تحقق من الاتصال بالانترنت", context);
//     } finally {
//       if (auth) {
//         Get.back();
//         customSnackBar(title: 'تم الاضافه', content: "تمت الاضافه بنجاح");
//         Future.delayed(Duration(seconds: 1)).then(
//           (value) => Get.offAll(
//             () => MainPage(index: 3),
//             transition: Transition.zoom,
//           ),
//         );
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
