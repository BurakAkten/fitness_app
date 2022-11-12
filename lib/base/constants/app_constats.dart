import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color primary = Color(0xffFF9800);
  static const Color black = Color(0xff000a12);
  static const Color white = Color(0xfff5f5f5);
  static const Color secondary = Color(0xff9800FF);
  static const Color grey = Colors.blueGrey;
}

class AppSizes {
  static final buttonDefaultHeight = 50.h;
  static final rightIconSize = 50.w;
}

class AppFontUtils {
  static final double headline = 18.sp;
  static final double subtitle = 16.sp;
  static final double body = 14.sp;
  static final double button = 12.sp;
  static final double caption = 10.sp;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w600;
  static const FontWeight bold = FontWeight.w800;
}

class AppSpacing {
  static const int spacingXSmall = 4;
  static const int spacingSmall = 8;
  static const int spacingMedium = 12;
}
