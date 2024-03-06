import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createScheduledNotification(
    int id, String title, String body, DateTime scheduleTime) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'scheduled_notifications',
          title: title,
          criticalAlert: true,
          body: body,
          wakeUpScreen: true,
          autoDismissible: true,
          notificationLayout: NotificationLayout.Default),
      schedule: NotificationCalendar(
          day: scheduleTime.day,
          month: scheduleTime.month,
          year: scheduleTime.year,
          hour: scheduleTime.hour,
          minute: scheduleTime.minute,
          second: 0,
          millisecond: 0,
          timeZone: 'Asia/Jakarta',
          repeats: false,
          allowWhileIdle: true));
}

Future<void> cancelNotification(int id) async {
  await AwesomeNotifications().cancel(id);
}
