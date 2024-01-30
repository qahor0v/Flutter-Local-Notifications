import 'dart:developer';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class NotificationServices {
  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('app_icon');
  DarwinInitializationSettings initializationSettingsDarwin =
  const DarwinInitializationSettings();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings)
        .then((value) {
      log("Notification status: $value ");
    });
  }

  Future<void> testNotification() async {
    await flutterLocalNotificationsPlugin.show(
      21,
      "title",
      "body",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
    );
  }

  Future<void> setNotification(TZDateTime date) async {
     log("$date");
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'scheduled title',
        'scheduled body',
        date,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            channelDescription: 'your channel description',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
      log('Notification scheduled!');
    } catch (error) {
      log('Error: $error');
    }
  }
}