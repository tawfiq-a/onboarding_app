import 'package:get/get.dart';



import '../common_widgets/location_screen.dart';
import '../common_widgets/onboarding_screen.dart';

class Routes{
  static String onboardingScreen = "/onboarding_screen";
  static String locatinScreen = "/location_screen";

}

List<GetPage> pages=[
  GetPage(name: Routes.onboardingScreen, page: () => const OnboardingScreen()),
  GetPage(name: Routes.locatinScreen, page: () => const LocationScreen()),


];



