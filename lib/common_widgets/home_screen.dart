import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../constants/gradient_background.dart';
import '../features/alarm/alarm_controller.dart';
import '../features/location/controllers/location_controller.dart';
import '../helpers/custom_alarm_toggle.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final LocationController locationController = Get.find();


  final AlarmsController alarmsController = Get.put(AlarmsController());

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ever(locationController.selectedLocation, (value) {
      textController.text = value.address;
    });

    textController.text = locationController.selectedLocation.value.address;

    return Scaffold(
      // Add the Floating Action Button
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          // Add a new alarm set for 1 hour from the current time
          alarmsController.addAlarm(DateTime.now().add(const Duration(hours: 1)));
        },
        backgroundColor: Colors.blueAccent.shade700,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 50),
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
                  textAlign: TextAlign.center,
                  readOnly: true,
                  style: const TextStyle(color: Colors.white, fontSize: 20,),

                  controller: textController,
                  decoration: const InputDecoration(

                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
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


                Obx(
                      () => Column(
                    children: alarmsController.alarms.map((alarm) {

                      return AlarmToggleWidget(
                        key: ValueKey(alarm.id),
                        alarm: alarm,
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}