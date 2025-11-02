import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_widgets/home_screen.dart';
import 'common_widgets/onboarding_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Onboarding App",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF6B00F5),
        scaffoldBackgroundColor: Color(0xFF0A0027),

      ),
      home: OnboardingScreen(),




    );
  }
}
