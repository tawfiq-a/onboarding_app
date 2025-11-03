

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../../constants/app_colors.dart';
import '../models/location_models.dart';


class LocationController extends GetxController {

  // Location data
  final Rx<UserLocation> selectedLocation = UserLocation.initial.obs;

  // Loading state
  final RxBool isLoading = false.obs;
  // fetched location
  final fetchedLocation = ''.obs;

  bool get isLocationSelected => selectedLocation.value.latitude != 0.0 && selectedLocation.value.longitude != 0.0;


  Future<void> requestAndFetchLocation() async {
    isLoading.value = true;
    // Clear fetched location
    fetchedLocation.value = '';

    // Permission check
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        isLoading.value = false;
        Get.snackbar(
          "Permission Denied",
          "Please grant location access from settings to use this feature.",
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }

    // Location fetch
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        timeLimit: const Duration(seconds: 10),
      );

      // Fetch address from coordinates
      String address = await _getAddressFromCoordinates(position.latitude, position.longitude);

      // Step 4: State update kora
      selectedLocation.value = UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      );



      fetchedLocation.value = address.contains("Geocoding Failed") ? 'Location Found (Check Logs)' : address;


      Get.snackbar(
          "Location Fetched",
          address.contains("Geocoding Failed")
              ? "Geocoding failed. Using coordinates: ${position.latitude.toStringAsFixed(3)}, ${position.longitude.toStringAsFixed(3)}"
              : "Location fetched: $address",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          colorText: Colors.white,
      );

    } catch (e) {
      Get.snackbar("Error", "location fetch error: $e");


    } finally {
      isLoading.value = false;
    }
  }

  //  Geocoding timeout handling
  Future<String> _getAddressFromCoordinates(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon)
          .timeout(const Duration(seconds: 5));

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = "${place.locality ?? place.name}, ${place.country}";
        return address.trim();
      }
      return "Unknown Location";
    } catch (e) {

      print("Geocoding failed error: $e");
      return "Geocoding Failed";
    }
  }

  void proceedToHome() {
    if (isLocationSelected) {
      Get.toNamed("/home_screen");
    } else {
      Get.snackbar(
        "Location Required",
        "Please use 'Use Current Location' to fetch your location first.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: AppColors.white,

        duration: const Duration(seconds: 1),
      );
    }
  }
}