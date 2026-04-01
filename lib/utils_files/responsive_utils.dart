import 'package:flutter/material.dart';

int getGridCrossAxisCount(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  if (width >= 1200) return 4;
  if (width >= 900)  return 3;   // or 840 if you prefer Material 3 expanded
  if (width >= 600)  return 3;   // tablets get 3 too (looks nice)
  return 2;                      // phones
}