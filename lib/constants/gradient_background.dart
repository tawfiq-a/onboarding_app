

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(
        gradient: LinearGradient(

          begin: Alignment.topCenter,

          end: Alignment.bottomCenter,

          colors: AppColors.backgroundGradient,
        ),
      ),
      child: child,
    );
  }
}