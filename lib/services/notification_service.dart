import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // A singleton pattern to ensure only one instance of the service is created.
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  // The instance of the local notifications plugin.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initializes the notification service and sets up platform-specific settings.
  Future<void> init() async {
    // Android initialization settings.
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings.
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        );

    // Combine the platform-specific settings.
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    // Initialize the timezone database.
    tz.initializeTimeZones();

    // Initialize the plugin with the settings.
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Requests notification permissions for iOS.
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  // Schedules a notification to appear at a specific time.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    // Ensure the scheduled date is in the future.
    if (scheduledDate.isBefore(DateTime.now())) {
      print("Attempted to schedule a notification in the past. Aborting.");
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'subscription_channel_id', // Channel ID
          'Subscription Reminders', // Channel Name
          channelDescription: 'Channel for subscription payment reminders',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      // androidAllowWhileIdle: true,
      //  uiLocalNotificationDateInterpretation:
      //    UILocalNotificationDateInterpretation.absoluteTime, androidScheduleMode: null,
    );
  }
}
