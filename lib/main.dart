
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'alarm/alarm_controller.dart';
import 'features/location/controllers/location_controller.dart';
import 'helpers/routes.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(LocationController());
    Get.put(AlarmsController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Onboarding App",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF6B00F5),
        scaffoldBackgroundColor: Color(0xFF0A0027),

      ),
     initialRoute: '/onboarding_screen',
      getPages: pages,



    );
  }
}
