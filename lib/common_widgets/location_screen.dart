// lib/features/location/presentation/location_screen.dart (UPDATED)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../constants/gradient_background.dart';
import '../features/location/controllers/location_controller.dart';

// Home screen ekhane import kora dorkar nei, controller handle korbe

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent, // main.dart theke gradient pabar janyo
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // MainAxisAlignment.spaceAround use kora holo, design er spacing er janyo
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1. Top Content (Title, Description, Image)
              Column(
                children: [
                  SizedBox(height: size.height * 0.05), // Ektu niche namano

                  // Title
                  const Text(
                    "Welcome! Your Smart Travel Alarm",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Description
                  Text(
                    "Stay on schedule and enjoy every \n moment of your journey.", // Design-er text
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.lightWhite,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),



                  ClipRRect(
                    child: Image.asset(
                      'assets/locationImage.png',
                      width: size.width * 0.8,
                      height: size.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              // 2. Bottom Actions (Location Status & Buttons)
              Column(
                children: [
                  // Use Current Location Button (Design er "Use-Current Location" button)
                  // Ekhane Obx use kora holo jate loading state dekhan jay
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: controller.requestAndFetchLocation,
                      style: ElevatedButton.styleFrom(

                        backgroundColor: AppColors.gradientEnd, // Transparent button background
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.white),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator(color: AppColors.white)
                          : const Icon(Icons.location_on_outlined, size: 24)),
                      label: Obx(() => Text(
                        controller.isLoading.value
                            ? 'Fetching Location...'
                            : 'Use-Current Location',
                        style: const TextStyle(fontSize: 18),
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Proceed Button (Design-er moto)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: controller.proceedToHome,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),

                      child: const Text('Home', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}