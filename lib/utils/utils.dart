import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart'
    hide DateUtils;
import 'package:awesome_notifications/awesome_notifications.dart' as Utils
    show DateUtils;
import 'package:flutter/material.dart';
import 'package:reminder_app/constants.dart';

Future<void> showBasicNotification(int id) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: id,
    channelKey: 'basic_channel', //'basic_channel',//'custom_sound',//
    title: 'Simple Notification',
    body: 'Simple body',
  ));
}

Future<bool> showNotificationWithActionButtons(
    int id, DateTime scheduleTime) {
  return AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: 'Good night! Its time to sleep',
          body: 'Sleep early. Stay healthy.',
          payload: {'uuid': 'user-profile-uuid'}),
      schedule: NotificationCalendar(
          weekday: Platform.isIOS
              ? scheduleTime.weekday
              : scheduleTime.toUtc().weekday,
          allowWhileIdle: true,
          hour: Platform.isIOS ? scheduleTime.hour : scheduleTime.toUtc().hour,
          minute: Platform.isIOS
              ? scheduleTime.minute
              : scheduleTime.toUtc().minute,
          second: 0,
          repeats: true),
      actionButtons: [
        NotificationActionButton(
            key: ConstantKey.sleepNow, label: 'Okay, Got it', autoCancel: true),
        NotificationActionButton(
          key: ConstantKey.sleepLater,
          label: "I'll sleep later",
          autoCancel: true,
        )
      ]);
}

Future<bool> showNotificationAtScheduleCron(
    int id, DateTime scheduleTime) {
  return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled',
        title: 'Just in time!',
        body: 'This notification was schedule to shows at ' +
            (Utils.DateUtils.parseDateToString(scheduleTime.toLocal()) ?? '?') +
            '(' +
            (Utils.DateUtils.parseDateToString(scheduleTime.toUtc()) ?? '?') +
            ' utc)',
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/images/delivery.jpeg',
        payload: {'uuid': 'uuid-test'},
        autoCancel: false,
      ),
      schedule: NotificationCalendar(
          weekday: Platform.isIOS
              ? scheduleTime.weekday
              : scheduleTime.toUtc().weekday,
          allowWhileIdle: true,
          hour: Platform.isIOS ? scheduleTime.hour : scheduleTime.toUtc().hour,
          minute: Platform.isIOS
              ? scheduleTime.minute
              : scheduleTime.toUtc().minute,
          second: 0,
          repeats: true));
}

Future<void> listScheduledNotifications(BuildContext context) async {
  List<PushNotification> activeSchedules =
      await AwesomeNotifications().listScheduledNotifications();
  for (PushNotification schedule in activeSchedules) {
    debugPrint(
        'pending notification: [id: ${schedule.content.id}, title: ${schedule.content.titleWithoutHtml}, schedule: ${schedule.schedule.toString()}]');
  }
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('${activeSchedules.length} schedules founded'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> cancelAllSchedules() async {

  await AwesomeNotifications().cancelAllSchedules();
}
