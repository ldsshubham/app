import 'package:flutter/material.dart';

class AppColors {

  static const Color primaryColor = Color(0xFF0F1020);
  static const Color white = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFF1D263B);
  static const Color error = Color(0xFFCC2936);
  static const Color success = Color(0xFF8FF7A7);
  static const Color green = Color(0xFF009900);
  static const Color warning = Color(0xFFF44708);
  static const Color gray = Color(0xFFA0AAB2);
  final Gradient circularGradient = RadialGradient(
  center: Alignment.center,
  radius: 0.8,
  colors: [
    Colors.pink,
    Colors.lightBlue,
    Colors.green,
  ],
  );
}