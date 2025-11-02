
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constants/app_colors.dart';
import '../constants/gradient_background.dart';
import '../features/onboarding/controllers/onboarding_controller.dart';
import '../features/onboarding/models/onboarding_model.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get Controller
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: GradientBackground(
        child: Stack(
          children: [
            //  PageView - main content
            PageView.builder(
              controller: controller.pageController,
              itemCount: OnboardingModel.onboardingData.length,
              itemBuilder: (context, index) {
                final data = OnboardingModel.onboardingData[index];
                return OnboardingPage(
                  imageUrl: data.imageUrl,
                  title: data.title,
                  description: data.description,
                );
              },
            ),

            // 2. Dots & Buttons
            Container(
              alignment: const Alignment(0, 0.95),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Page Indicator Dots
                  SmoothPageIndicator(
                    onDotClicked: (index) => controller.pageController.animateToPage(
                      index,
                      duration: const Duration(seconds:3),
                      curve: Curves.easeIn,
                    ),

                    controller: controller.pageController,
                    count: OnboardingModel.onboardingData.length,
                    effect: const ExpandingDotsEffect(

                      activeDotColor: AppColors.primaryPurple,
                      dotColor: AppColors.indicatorDot,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,

                    ),
                  ),
                  const SizedBox(height: 30),

                  // Next/ Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                      ),
                      child: Obx(() => Text(
                        controller.onLastPage.value ? 'Get Started' : 'Next',
                        style: const TextStyle(fontSize: 18,color: AppColors.white),
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            //  Skip Button
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: controller.skipOnboarding, // Call the skip function
                child: const Text(
                  'Skip',
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Onboarding pages UI
class OnboardingPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Container(
                decoration: BoxDecoration(

                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                )),
          ),
        ),

        // Text Content
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (Bold White Text)
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                // Description
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.lightWhite,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}