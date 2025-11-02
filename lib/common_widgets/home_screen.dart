import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../alarm/alarm_controller.dart';
import '../constants/gradient_background.dart';
import '../features/location/controllers/location_controller.dart';
import '../helpers/alarm_custom.dart';
// Note: Removed unused import '../helpers/alarm_custom.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final LocationController locationController = Get.find();

  // 💡 Instantiate the AlarmsController
  final AlarmsController alarmsController = Get.put(AlarmsController());

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ever(locationController.selectedLocation, (value) {
      textController.text = value.address;
    });

    textController.text = locationController.selectedLocation.value.address;

    return Scaffold(
      // 🌟 STEP 1: Add the Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new alarm set for 1 hour from the current time
          alarmsController.addAlarm(DateTime.now().add(const Duration(hours: 1)));
        },
        backgroundColor: Colors.blueAccent.shade700,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_alarm, color: Colors.white, size: 30),
      ),

      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40,),
                const Text(
                  "Selected Location:",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  readOnly: true,
                  style: const TextStyle(color: Colors.white),
                  controller: textController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    labelText: "Location",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Alarms",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // 🌟 STEP 2: Use Obx to display the list of alarms dynamically
                Obx(
                      () => Column(
                    children: alarmsController.alarms.map((alarm) {
                      // 🌟 Use the new AlarmToggleWidget
                      return AlarmToggleWidget(
                        key: ValueKey(alarm.id), // Important for performance and state
                        alarm: alarm,
                      );
                    }).toList(),
                  ),
                ),
                // Add padding at the bottom to ensure the last alarm is not hidden by the FAB
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}