import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavVisibilityProvider with ChangeNotifier {
  final ValueNotifier<bool> isVisible = ValueNotifier(true);

  // For smoother control
  double _lastOffset = 0.0;
  static const double _threshold = 10.0; // pixels — adjust this (10-40 is good)

  void onScroll(ScrollController controller) {
    if (!controller.hasClients) return;

    final currentOffset = controller.offset;
    final direction = controller.position.userScrollDirection;

    bool shouldHide = false;

    if (direction == ScrollDirection.reverse && 
        currentOffset - _lastOffset > _threshold) {
      shouldHide = true;
    } else if (direction == ScrollDirection.forward && 
               _lastOffset - currentOffset > _threshold) {
      shouldHide = false;
    } else {
      return; // ignore small movements
    }

    if (isVisible.value != shouldHide) {
      isVisible.value = shouldHide;
    }

    _lastOffset = currentOffset;
  }
  @override
  void dispose() {
    isVisible.dispose();
    super.dispose();
  }
}