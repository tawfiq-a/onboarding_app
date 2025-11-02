import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/location_screen.dart';
import '../models/onboarding_model.dart';


class OnboardingController extends GetxController {

  // PageView current index
  final RxInt currentPageIndex = 0.obs;
  // Check if last page
  final RxBool onLastPage = false.obs;

  // PageView widget controller
  final PageController pageController = PageController();

  @override
  void onInit() {
    // set listener to PageController
    pageController.addListener(_onPageChanged);
    super.onInit();
  }

  void _onPageChanged() {
    if (pageController.page != null) {
      // To update Current index
      currentPageIndex.value = pageController.page!.round();
      // Check if last page
      onLastPage.value = currentPageIndex.value == OnboardingModel.onboardingData.length - 1;
    }
  }

  void nextPage() {
    if (onLastPage.value) {
      // If last page, navigate to Location Screen
      Get.offAll(() => const LocationScreen());
    } else {
      // Scroll to next page
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  void skipOnboarding() {
    // Press skip, navigate to Location Screen
    Get.offAll(() => const LocationScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}