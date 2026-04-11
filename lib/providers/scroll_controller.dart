// scroll_controller_provider.dart
import 'package:flutter/material.dart';

class ScrollControllerProvider with ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}