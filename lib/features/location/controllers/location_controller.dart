

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../models/location_models.dart';


class LocationController extends GetxController {

  // Location data: Reactive variable jeta UI te location dekhanor janyo use hobe
  final Rx<UserLocation> selectedLocation = UserLocation.initial.obs;

  // Loading state: Location fetching cholche kina
  final RxBool isLoading = false.obs;

  Future<void> requestAndFetchLocation() async {
    isLoading.value = true;

    // Step 1: Permission check
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

    // Step 2: Location fetch kora
    try {
      Position position = await Geolocator.getCurrentPosition(

        desiredAccuracy: LocationAccuracy.bestForNavigation,
        timeLimit: const Duration(seconds: 10),
      );

      // Step 3: Coordinates theke address fetch kora
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
      // ... (Error handling code is the same) ...
    } finally {
      isLoading.value = false;
    }
  }

  // 👇 Ekhane Geocoding timeout handling add kora holo
  Future<String> _getAddressFromCoordinates(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon)
          .timeout(const Duration(seconds: 5)); // 👈 5 second timeout add kora holo

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = "${place.locality ?? place.name}, ${place.country}";
        return address.trim();
      }
      return "Unknown Location";
    } catch (e) {
      // Timeout ba kono network shomoshar janyo Geocoding fail hole
      print("Geocoding failed error: $e");
      return "Geocoding Failed"; // Eta snack bar-e dekha jabe
    }
  }

  void proceedToHome() {
    // Location select howar por Home Screen-e navigate kora
   Get.toNamed("/home_screen");


  }
}