

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';


import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../features/alarm/alarm_controller.dart';
import '../helpers/alarm_model.dart';




class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  factory NotificationService() => instance;
  NotificationService._internal();


  Future<void> initNotification() async {
    tz.initializeTimeZones();

    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {

      AwesomeNotifications().requestPermissionToSendNotifications();
    }

    AwesomeNotifications().initialize(
      'resource://drawable/alarm_icon',
      [
        NotificationChannel(
          channelKey: 'alarm_channel_key',
          channelName: 'Time Alarm Notifications',
          channelDescription: 'Channel for scheduled time alarm notifications',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          locked: true,
          channelShowBadge: true,
        )
      ],
      debug: true,
    );
  }


  static Future<void> startListeningNotificationEvents() async {

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }




  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    final alarmIdString = receivedAction.payload?['alarmId'];

    if (receivedAction.channelKey == 'alarm_channel_key' && alarmIdString != null) {
      final alarmId = int.tryParse(alarmIdString);

      await AwesomeNotifications().cancel(receivedAction.id!);

      if (alarmId != null && Get.isRegistered<AlarmsController>()) {
        final controller = Get.find<AlarmsController>();

        controller.toggleAlarm(alarmId, false);
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    //
  }
  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    //
  }
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    //
  }


  Future<void> scheduleAlarmNotification(AlarmModel alarm) async {
    if (!alarm.isOn || alarm.time.isBefore(DateTime.now().subtract(const Duration(seconds: 5)))) {
      await cancelNotification(alarm.id);
      return;
    }

    final scheduledTime = tz.TZDateTime.from(
        alarm.time,
        tz.local
    );

    await cancelNotification(alarm.id);

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: alarm.id,
          channelKey: 'alarm_channel_key',
          title: '🔔 Alarm Ringing!',
          body: 'Time: ${DateFormat('h:mm a').format(alarm.time)}',
          notificationLayout: NotificationLayout.Default,
          locked: true,
          wakeUpScreen: true,
          category: NotificationCategory.Alarm,
          payload: {'alarmId': alarm.id.toString()},
          autoDismissible: false,
        ),
        schedule: NotificationCalendar(
          year: scheduledTime.year,
          month: scheduledTime.month,
          day: scheduledTime.day,
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
          millisecond: 0,
          timeZone: scheduledTime.location.name,
          repeats: false,
        )
    );
    print("Alarm Scheduled (Awesome): ID ${alarm.id} at ${alarm.time}");
  }


  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
    print("Alarm Cancelled (Awesome): ID $id");
  }
}