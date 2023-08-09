import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:langpocket/src/utils/constants/globule_constants.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/utils/permissions.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// todo : user preference time to study
// ask when login
// make it changeable in setting

// ignore: constant_identifier_names
const Default_STUDY_HOUR = 9;

class AppNotification {
  final notification = FlutterLocalNotificationsPlugin();
  void initializations() async {
    tz.initializeTimeZones();
    final permission = await Permissions().requestNotifications();
    if (permission) {
      const android = AndroidInitializationSettings('app_icon');
      const ios = DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: true);
      const initializationSettings =
          InitializationSettings(android: android, iOS: ios);

      await notification.initialize(initializationSettings);
    }
  }

  // 1 make new group notification
  void newGroupNotification() async {
    const titleMessage = 'Boost Your Vocabulary Today!';
    const bodyMessage = "Hey there! Ready to learn new words?";
    int dayCount = 0;
    final localTime = await getLocalTimeZone();
    final localTimeZone = tz.getLocation(localTime);
    notificationDays.forEach((key, value) {
      final now = DateTime.now();
      final scheduleTime =
          DateTime(now.year, now.month, now.day, DEFAULT_DAY_ID)
              .add(Duration(days: dayCount));
      final notificationTime = tz.TZDateTime.from(scheduleTime, localTimeZone);
      _scheduleNotification(
        value,
        notificationTime,
        titleMessage,
        bodyMessage,
      );
      dayCount += 1;
    });
  }

  Future<String> getLocalTimeZone() async {
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    return timeZoneName;
  }

  void removeNewGroupNotification(int id) {
    notification.cancel(id);
  }

  void notificationMapper(GroupData group, String wordToDisplay) async {
    final localTime = await getLocalTimeZone();
    final today = tz.TZDateTime.now(tz.getLocation(localTime));

    if (group.level == 1) {
      _practiceGroupTomorrow(group.id, today, wordToDisplay);
      return;
    }
    if (group.level == 2) {
      // yesterday
      _practiceGroup3daysAfter(group.id, today, wordToDisplay);
      return;
    }
    if (group.level == 3) {
      _practiceGroupOneWeekAfter(group.id, today, wordToDisplay);
      return;
    }
    if (group.level == 4) {
      _practiceGroup2WeeksAfter(group.id, today, wordToDisplay);
      return;
    }
    if (group.level == 5) {
      _practiceGroupOnMonthAfter(group.id, today, wordToDisplay);
    }
    if (group.level == 6) {
      _practiceGroup3MonthsAfter(group.id, today, wordToDisplay);
      return;
    }
    if (group.level == 7) {
      _practiceGroup6MonthsAfter(group.id, today, wordToDisplay);
      return;
    }
    if (group.level == 8) {
      _practiceGroupOneYear(group.id, today, wordToDisplay);
      return;
    }
  }

  void _scheduleNotification(
    int id,
    tz.TZDateTime scheduledTime,
    String taskTitle,
    String taskBody,
  ) async {
    const android = AndroidNotificationDetails(
      'langpocket',
      'LangPocket',
      channelDescription:
          'Reminders about the words you\'ve added and tasks in your to-do list.',
      importance: Importance.max,
      priority: Priority.max,
    );
    const ios = DarwinNotificationDetails();
    const platformChannelSpecifics =
        NotificationDetails(android: android, iOS: ios);
    await notification.zonedSchedule(
        id, taskTitle, taskBody, scheduledTime, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // 2 practice words tomorrow  Lever 1
  void _practiceGroupTomorrow(int groupId, tz.TZDateTime today, String word) {
    final tomorrow = today.add(const Duration(days: 1));
    _scheduleNotification(
        groupId,
        tomorrow,
        'Time to Review Yesterday\'s Words! 📚',
        'Remember the words you added yesterday like:  "$word"... ? It\'s their time to shine! Dive in now and make them part of your vocabulary 💪');
  }

// 3 practice words  after 3 days Level 2
  void _practiceGroup3daysAfter(int groupId, tz.TZDateTime today, String word) {
    final future = today.add(const Duration(days: 3));
    _scheduleNotification(groupId, future, 'Time for a Quick Review! 🌟',
        'You practiced words like: "$word"... three days ago. Open the app to reinforce your memory. Keep up the great work! 💪');
  }

// 4 practice words  one week days Level 3
  void _practiceGroupOneWeekAfter(
      int groupId, tz.TZDateTime today, String word) {
    final future = today.add(const Duration(days: 7));
    _scheduleNotification(groupId, future, 'Weekly Review Reminder! 📘',
        'A week ago, you nailed words: "$word"... Let\'s revisit them to ensure they stick! Open the app and keep your learning streak alive 💪');
  }

// 5 practice words 2 weeks  Level 4
  void _practiceGroup2WeeksAfter(
      int groupId, tz.TZDateTime today, String word) {
    final future = today.add(const Duration(days: 14));
    _scheduleNotification(groupId, future, 'Two-Week Review Time! 🎉',
        'It\'s been two weeks since you conquered words like: "$word"... Let\'s revisit them to cement your mastery! Open the app and continue your impressive learning journey. 💪');
  }

// 6 practice words one month Level 5
  void _practiceGroupOnMonthAfter(
      int groupId, tz.TZDateTime today, String word) {
    final future = today.add(const Duration(days: 30));
    _scheduleNotification(groupId, future, 'One-Month Mastery Check! 🎓',
        'It\'s been an entire month since you aced words like: "$word"... Time to revisit them and see how well they\'ve stuck. Open the app and take a moment to review. Keep up the fantastic work 🚀');
  }

// 7 practice words 3 month Level 6
  void _practiceGroup3MonthsAfter(
      int groupId, tz.TZDateTime today, String word) {
    final future = today.add(const Duration(days: 90));
    _scheduleNotification(groupId, future, 'Three-Month Review Time! 🌱',
        'Wow! Three months ago, you practiced and mastered words likes: "$word "... Time flies, doesn\'t it? Let\'s revisit them to make sure they\'re still fresh in your memory. Open the app and take a quick review. 🚀');
  }

// 8 practice words 6 month Level 7
  void _practiceGroup6MonthsAfter(
      int groupId, tz.TZDateTime today, String word) {
    final future = today.add(const Duration(days: 180));
    _scheduleNotification(groupId, future, 'Six-Month Mastery Check! 🏆',
        'Open the app and revisit the words like: $word .. , you practiced them six months ago. A quick review keeps them fresh 💪');
  }

  // 9 practice words one month Level 8
  void _practiceGroupOneYear(int groupId, tz.TZDateTime today, String word) {
    final future = today.add(const Duration(days: 360));
    _scheduleNotification(
        groupId,
        future,
        'One Year Later: Time to Celebrate Your Progress! 🎉',
        'A year ago, you began learning some incredible words like: "$word...". Open the app now to review and reflect on how far you\'ve come. Your dedication deserves applause! 👏');
  }
}
