import 'package:flutter/material.dart';

class AppColor {
  static const MaterialColor primary = MaterialColor(_primary, <int, Color>{
    50: Color(0xFFECEBFF),
    100: Color(0xFFD0CEFF),
    200: Color(0xFFB1ADFF),
    300: Color(0xFF928CFF),
    400: Color(0xFF7A74FF),
    500: Color(_primary),
    600: Color(0xFF5B53FF),
    700: Color(0xFF5149FF),
    800: Color(0xFF4740FF),
    900: Color(0xFF352FFF),
  });
  static const int _primary = 0xFF635BFF;

  static const MaterialColor accent = MaterialColor(_accentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_accentValue),
    400: Color(0xFFDBDAFF),
    700: Color(0xFFC3C1FF),
  });
  static const int _accentValue = 0xFFFFFFFF;
}
