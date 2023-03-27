import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> initNotifications() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> scheduleKanjiNotification(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  int notificationId,
  String kanjiCharacter,
  String kanjiMeaning,
  DateTime notificationTime,
) async {
  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'kanji_channel_id',
    'Kanji Channel',
    'Channel for displaying daily kanji',
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
  );
  const platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationId,
    'Today\'s kanji: $kanjiCharacter',
    kanjiMeaning,
    tz.TZDateTime.from(notificationTime, tz.local),
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
