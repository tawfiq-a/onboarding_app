// lib/common_widgets/gradient_background.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child; // Gradient-er opore jei content thakbe

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Shobcheye bhalo upaye holo Container-er decoration use kora
    return Container(
      // Container-ti puro screen-er size nibe
      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          // Gradient shuru hobe top theke
          begin: Alignment.topCenter,
          // Shesh hobe bottom-e
          end: Alignment.bottomCenter,
          // Apnar define kora colors list
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: child, // Gradient-er opore apnar screen content thakbe
    );
  }
}