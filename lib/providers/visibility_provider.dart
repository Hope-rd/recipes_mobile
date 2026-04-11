import 'package:flutter/material.dart';

class NavVisibilityProvider with ChangeNotifier {
  final ValueNotifier<bool> isVisible = ValueNotifier(true);

  void updateVisibility(bool visible) {
    if (isVisible.value != visible) {
      isVisible.value = visible;
      notifyListeners(); // Optional if you use the notifier directly
    }
  }

  @override
  void dispose() {
    isVisible.dispose();
    super.dispose();
  }
}