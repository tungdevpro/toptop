import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  static const Color primary = Color(0xffFEA623);
  static Color primary90 = const Color(0xffFEA623).withOpacity(.9);
  static Color primary70 = const Color(0xffFEA623).withOpacity(.7);
  static Color primary50 = const Color(0xffFEA623).withOpacity(.5);
  static Color primary30 = const Color(0xffFEA623).withOpacity(.3);
  static Color primary10 = const Color(0xffFEA623).withOpacity(.1);

  static const Color background1 = Color(0xffFCFCFC);
  static const Color line = Color(0xffEFEFEF);
  static const Color blue = Color(0xffEFEFEF);
  static const Color red = Color(0xffEFEFEF);
  static const Color text = Color(0xffEFEFEF);
  static const Color title = Color(0xffEFEFEF);
  static const Color icon = Color(0xffEFEFEF);
}
