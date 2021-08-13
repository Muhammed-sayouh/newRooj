import 'package:flutter/cupertino.dart';

class AdditionalPersonModel {
  int? id;
  String? name;
  String? priceTxt;
  int price;
  double? sale;
  String? duration;
  bool selected;
  AdditionalPersonModel({
    this.id,
    this.name,
    this.priceTxt,
    required this.price,
    this.sale,
    this.duration,
    required this.selected,
  });
}

class AdditionalPersonProvider with ChangeNotifier {
  List<AdditionalPersonModel> services = [
    AdditionalPersonModel(
      id: 0,
      name: "شخص اضافى",
      priceTxt: "15 ريال",
      price: 15,
      sale: 70,
      selected: false,
      duration: "15 دقيقه",
    ),
    AdditionalPersonModel(
      id: 1,
      name: "شخص اضافى",
      priceTxt: "15 ريال",
      price: 15,
      sale: 222,
      selected: false,
      duration: "15 دقيقه",
    ),
    AdditionalPersonModel(
      id: 2,
      name: "شخص اضافى",
      priceTxt: "15 ريال",
      price: 15,
      sale: 550.49,
      selected: false,
      duration: "15 دقيقه",
    ),
    AdditionalPersonModel(
      id: 3,
      name: "شخص اضافى",
      priceTxt: "15 ريال",
      price: 15,
      sale: 500,
      selected: false,
      duration: "15 دقيقه",
    ),
  ];
  List<AdditionalPersonModel> myWorkres = [];
  void addnewItem(int id) {
    myWorkres.add(services.firstWhere((element) => element.id == id));
  }
}
