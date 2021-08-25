import 'package:flutter/material.dart';
import 'package:rooj/style/colors.dart';

class ItemForSalonDetails extends ChangeNotifier {
  ItemForSalonDetails({required String name, required Color color}) {
    _name = name;
    _color = color;
  }

  int? selectedIndex = -1; // to know active index
  late String _name;
  // ignore: unused_field
  late Color _color;

  String getName() {
    return _name;
  }

  void toggleSelected(int index) {
    selectedIndex = index;

    notifyListeners(); // To rebuild the Widget
  }

  void setColor(Color color) {
    _color = color;

    notifyListeners();
  }

  Color getColor() {
    return _color = AppColors.mainColor;
  }
}
