import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle bigText = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const TextStyle titleStyle = TextStyle(
    color: AppColors.peopleDark,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle normalText = TextStyle(
    fontSize: 16,
    color: AppColors.peopleDark,
  );
}
