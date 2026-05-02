import 'package:flutter/material.dart';

class SetCategoriesProvider extends ChangeNotifier {
  List<String> _selectedCategories = [];

  List<String> get selectedCategories => _selectedCategories;

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }
}