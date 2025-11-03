import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../features/alarm/alarm_controller.dart';
import 'alarm_model.dart';

class AlarmToggleWidget extends GetView<AlarmsController> {
  final AlarmModel alarm;

  const AlarmToggleWidget({super.key, required this.alarm});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade900,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tappable Time Display
          InkWell(
            onTap: () => controller.selectTime(alarm.id),
            child: Text(
              controller.formatTime(alarm.time),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Spacer(),

          // Tappable Date Display
          InkWell(
            onTap: () => controller.selectDate(alarm.id),
            child: Text(
              controller.formatDate(alarm.time),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(width: 10),


          //  Switch Control

          Switch(
            value: alarm.isOn,
            onChanged: (newValue) => controller.toggleAlarm(alarm.id, newValue),
            activeColor: Colors.white,
            activeTrackColor: Colors.blueAccent.shade700,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}