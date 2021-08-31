import 'package:flutter/cupertino.dart';

import 'salonItemDetailsProvider.dart';

class DayModel {
  String day;
  int id;
  bool selected;
  DayModel({
    required this.day,
    required this.id,
    required this.selected,
  });
}

class DaysProvider with ChangeNotifier {
  List<DayModel> selectedDays = [];
  List<Branch> selectedworkers = [];

  List<DayModel> days = [
    DayModel(day: 'saturday', id: 0, selected: false),
    DayModel(day: 'sunday', id: 1, selected: false),
    DayModel(day: 'monday', id: 2, selected: false),
    DayModel(day: 'tuesday', id: 3, selected: false),
    DayModel(day: 'wednesday', id: 4, selected: false),
    DayModel(day: 'thursday', id: 5, selected: false),
    DayModel(day: 'friday', id: 6, selected: false),
  ];

  void addToList(int id) {
    selectedDays.add(days.firstWhere((element) => element.id == id));
  }

  void removeFromList(int id) {
    selectedDays.remove(days.firstWhere((element) => element.id == id));
  }

  void addToListWorkrs(Branch value) {
    selectedworkers.add(value);
  }

  void removeFromListWorkrs(Branch value) {
    selectedDays.remove(value);
  }
}
