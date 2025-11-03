import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/alarm_model.dart';
import '../../helpers/notification_service.dart';


class AlarmsController extends GetxController {

  final RxList<AlarmModel> alarms = <AlarmModel>[].obs;
  final NotificationService _notificationService = NotificationService.instance;

  int _nextAlarmId = 0;


  @override
  void onInit() {
    super.onInit();
    // Initialize the notification service first
    _notificationService.initNotification();
    loadAlarms();
  }

  // --- LOCAL STORAGE FUNCTIONS ---

  // Alarm list save function
  Future<void> _saveAlarmsToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    // RxList to JSON String list convert
    final List<String> jsonList = alarms
        .map((alarm) => json.encode(alarm.toJson()))
        .toList();

    // save JSON String list to SharedPreferences
    await prefs.setStringList('alarms_data', jsonList);
    print("Alarms saved to storage.");
  }

  // Alarm list load function
  Future<void> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('alarms_data');

    if (jsonList != null && jsonList.isNotEmpty) {
      // JSON String list convert to AlarmModel list
      final loadedAlarms = jsonList
          .map((jsonString) => AlarmModel.fromJson(json.decode(jsonString)))
          .toList();

      // Update Rxlist
      alarms.assignAll(loadedAlarms);

      // Update _nextAlarmId for not conflict when new alarm added
      _nextAlarmId = (alarms.map((a) => a.id).reduce((a, b) => a > b ? a : b)) + 1;
      print("Alarms loaded from storage.");


      for (var alarm in alarms) {
        if (alarm.isOn) {
          _notificationService.scheduleAlarmNotification(alarm);
        }
      }

    } else {
      // If no saved data, set default alarms
      var now = DateTime.now();
      addAlarm(DateTime(now.year, now.month, now.day, 7, 00));
      addAlarm(DateTime(now.year, now.month, now.day, 19, 30));
    }
  }


  // --- CRUD FUNCTIONS WITH NOTIFICATION LOGIC ---

  void addAlarm(DateTime initialTime) {
    final newAlarm = AlarmModel(
      id: _nextAlarmId++,
      time: initialTime,
      isOn: true,
    );
    alarms.add(newAlarm);
    _saveAlarmsToStorage();


    _notificationService.scheduleAlarmNotification(newAlarm);
  }

  void toggleAlarm(int id, bool newValue) {
    final index = alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      alarms[index].isOn = newValue;
      alarms.refresh();
      _saveAlarmsToStorage();


      if (newValue) {
        _notificationService.scheduleAlarmNotification(alarms[index]);
      } else {
        _notificationService.cancelNotification(id);
      }
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
        _saveAlarmsToStorage();


        if (alarms[index].isOn) {
          _notificationService.scheduleAlarmNotification(alarms[index]);
        }
      }
    }
  }


  void selectDate(int id) async {
    final alarm = alarms.firstWhereOrNull((a) => a.id == id);
    if (alarm == null) return;

    final DateTime today = DateTime.now();
    final DateTime distantFuture = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: alarm.time,
      firstDate: today,
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
        _saveAlarmsToStorage();


        if (alarms[index].isOn) {
          _notificationService.scheduleAlarmNotification(alarms[index]);
        }
      }
    }
  }


  void deleteAlarm(int id) {
    alarms.removeWhere((alarm) => alarm.id == id);
    _saveAlarmsToStorage();


    _notificationService.cancelNotification(id);
  }


  String formatTime(DateTime time) => DateFormat('h:mm a').format(time);
  String formatDate(DateTime time) => DateFormat('E dd MMM yyyy').format(time);
}