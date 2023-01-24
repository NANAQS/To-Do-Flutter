import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_text_styles.dart';

import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamed("/main");
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: const Text(
          "TO DO app",
          style: AppTextStyles.bigText,
        ),
      ),
    );
  }
}
