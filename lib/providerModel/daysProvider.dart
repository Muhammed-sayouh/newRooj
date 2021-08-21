import 'package:flutter/cupertino.dart';

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

  List<DayModel> days = [
    DayModel(day: 'السبت', id: 0, selected: false),
    DayModel(day: 'الاحد', id: 1, selected: false),
    DayModel(day: 'الاثنين', id: 2, selected: false),
    DayModel(day: 'الثلاثاء', id: 3, selected: false),
    DayModel(day: 'الاربعاء', id: 4, selected: false),
    DayModel(day: 'الخميس', id: 5, selected: false),
    DayModel(day: 'الجمعه', id: 6, selected: false),
  ];

  void addToList(int id) {
    selectedDays.add(days.firstWhere((element) => element.id == id));
  }

  void removeFromList(int id) {
    selectedDays.remove(days.firstWhere((element) => element.id == id));
  }
}
