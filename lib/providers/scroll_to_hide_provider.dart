import 'package:flutter/material.dart';

class ScrollControllerProvider with ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  void disposeController() {
    scrollController.dispose();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}