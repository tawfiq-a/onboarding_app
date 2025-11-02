

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../models/location_models.dart';


class LocationController extends GetxController {

  // Location data
  final Rx<UserLocation> selectedLocation = UserLocation.initial.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  Future<void> requestAndFetchLocation() async {
    isLoading.value = true;

    // Permission check
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        isLoading.value = false;
        Get.snackbar(
          "Permission Denied",
          "Please grant location access from settings to use this feature.",
          snackPosition: SnackPosition.BOTTOM,
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


      Get.snackbar(
          "Location Fetched",
          address.contains("Geocoding Failed")
              ? "Geocoding failed. Using coordinates: ${position.latitude.toStringAsFixed(3)}, ${position.longitude.toStringAsFixed(3)}"
              : "Location fetched: $address",
          snackPosition: SnackPosition.BOTTOM,
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
    // navigate to home screen if location is selected
    Get.toNamed("/home_screen");}
}