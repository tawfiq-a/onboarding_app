import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/alarm/alarm_controller.dart';
import 'features/location/controllers/location_controller.dart';
import 'helpers/routes.dart';
import 'helpers/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.initNotification();
  NotificationService.startListeningNotificationEvents();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    Get.put(AlarmsController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Onboarding App",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF6B00F5),
        scaffoldBackgroundColor: const Color(0xFF0A0027),
      ),
      initialRoute: '/onboarding_screen',
      getPages: pages,
    );
  }
}
