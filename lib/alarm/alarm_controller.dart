import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../helpers/alarm_model.dart';


class AlarmsController extends GetxController {

  final RxList<AlarmModel> alarms = <AlarmModel>[].obs;
  int _nextAlarmId = 0;

  // (addAlarm, toggleAlarm, and selectTime methods remain the same)
  @override
  void onInit() {
    super.onInit();
    var now = DateTime.now();
    addAlarm(DateTime(now.year, now.month, now.day, 7, 00));
    addAlarm(DateTime(now.year, now.month, now.day, 19, 30));
  }

  void addAlarm(DateTime initialTime) {
    alarms.add(AlarmModel(
      id: _nextAlarmId++,
      time: initialTime,
      isOn: true,
    ));
  }

  void toggleAlarm(int id, bool newValue) {
    final index = alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      alarms[index].isOn = newValue;
      alarms.refresh();
    }
  }

  void selectTime(int id) async {
    final alarm = alarms.firstWhereOrNull((a) => a.id == id);
    if (alarm == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(alarm.time),
    );

    if (pickedTime != null) {
      final index = alarms.indexWhere((a) => a.id == id);
      if (index != -1) {
        alarms[index].time = DateTime(
          alarm.time.year,
          alarm.time.month,
          alarm.time.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        alarms.refresh();
      }
    }
  }

  // 🌟 UPDATED: Date Picker with No Effective Future Limit
  void selectDate(int id) async {
    final alarm = alarms.firstWhereOrNull((a) => a.id == id);
    if (alarm == null) return;

    // Use DateTime.now() to prevent picking past dates
    final DateTime today = DateTime.now();

    // 🎯 REMOVED LIMIT: Setting lastDate to the year 2100 (or any large year) allows the user
    // to scroll through many years in the picker.
    final DateTime distantFuture = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: alarm.time,

      // Keep restriction on past dates
      firstDate: today,

      // Lifted the limit
      lastDate: distantFuture,
    );

    if (pickedDate != null) {
      final index = alarms.indexWhere((a) => a.id == id);
      if (index != -1) {
        alarms[index].time = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          alarm.time.hour,
          alarm.time.minute,
        );
        alarms.refresh();
      }
    }
  }

  // (Helper Formatters remain the same)
  String formatTime(DateTime time) => DateFormat('h:mm a').format(time);
  String formatDate(DateTime time) => DateFormat('E dd MMM yyyy').format(time);
}