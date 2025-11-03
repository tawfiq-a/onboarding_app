import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../constants/gradient_background.dart';
import '../features/location/controllers/location_controller.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocationController>();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //  Top Content (Title, Description, Image)
                Column(
                  children: [
                    SizedBox(height: size.height * 0.05),

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
                const SizedBox(height: 100),

                //  Bottom Actions (Location Status & Buttons)
                Column(
                  children: [
                    // Use Current Location Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: controller.requestAndFetchLocation,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gradientEnd,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColors.white),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        icon: Obx(
                          () =>
                              controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                  : const Icon(
                                    Icons.location_on_outlined,
                                    size: 24,
                                  ),
                        ),
                        label: Obx(() {
                          if (controller.isLoading.value) {
                            return const Text(
                              'Fetching Location...',
                              style: TextStyle(fontSize: 18),
                            );
                          }

                          if (controller.fetchedLocation.isNotEmpty &&
                              controller.fetchedLocation.value !=
                                  'Location Found (Check Logs)') {
                            return Text(
                              controller
                                  .fetchedLocation
                                  .value,
                              style: const TextStyle(fontSize: 16),
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              maxLines: 1,
                            );
                          }


                          return const Text(
                            'Use Current Location',
                            style: TextStyle(fontSize: 18),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Proceed Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.proceedToHome();
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),

                        child: const Text(
                          'Home',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
