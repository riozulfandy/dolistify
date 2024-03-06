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
          category: NotificationCategory.Reminder,
          autoDismissible: false,
          notificationLayout: NotificationLayout.Default),
      schedule: NotificationCalendar.fromDate(
        date: scheduleTime,
        allowWhileIdle: true,
        preciseAlarm: true,
      ));
}

Future<void> cancelNotification(int id) async {
  await AwesomeNotifications().cancel(id);
}
