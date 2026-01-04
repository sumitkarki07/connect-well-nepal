import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
// ignore: unused_import
import 'package:timezone/data/latest_all.dart'; // Required for timezone data

/// LocalNotificationService - Handles local notifications for appointment reminders
///
/// Features:
/// - Schedule appointment reminders
/// - Cancel scheduled notifications
/// - Handle notification permissions
class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Initialize the notification service
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      // Initialize timezone database
      // The data file import automatically initializes timezones
      // Set local timezone to Kathmandu
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));
      } catch (e) {
        // If location not found, use UTC
        debugPrint('Could not set timezone to Asia/Kathmandu: $e');
      }

      // Android initialization settings
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS initialization settings
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      // Initialization settings
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Initialize plugin
      final initialized = await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      if (initialized ?? false) {
        _isInitialized = true;
        debugPrint('Local notifications initialized successfully');
      }

      return initialized ?? false;
    } catch (e) {
      debugPrint('Error initializing local notifications: $e');
      return false;
    }
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.id}');
    debugPrint('Payload: ${response.payload}');
    // TODO: Navigate to appointment details based on payload
  }

  /// Request notification permissions (iOS)
  Future<bool> requestPermissions() async {
    try {
      if (!_isInitialized) {
        await initialize();
      }

      final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        final granted = await androidPlugin.requestNotificationsPermission();
        return granted ?? false;
      }

      return true;
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return false;
    }
  }

  /// Schedule appointment reminder notification
  ///
  /// [appointmentId] - Unique ID for the appointment
  /// [doctorName] - Name of the doctor
  /// [appointmentDateTime] - Date and time of the appointment
  /// [reminderMinutes] - Minutes before appointment to show reminder (default: 30)
  Future<bool> scheduleAppointmentReminder({
    required String appointmentId,
    required String doctorName,
    required DateTime appointmentDateTime,
    int reminderMinutes = 30,
  }) async {
    try {
      if (!_isInitialized) {
        await initialize();
      }

      // Calculate reminder time
      final reminderTime = appointmentDateTime.subtract(
        Duration(minutes: reminderMinutes),
      );

      // Don't schedule if reminder time is in the past
      if (reminderTime.isBefore(DateTime.now())) {
        debugPrint('Reminder time is in the past, skipping notification');
        return false;
      }

      // Convert to timezone-aware datetime
      final scheduledDate = tz.TZDateTime.from(reminderTime, tz.local);

      // Notification details
      const androidDetails = AndroidNotificationDetails(
        'appointments',
        'Appointment Reminders',
        channelDescription: 'Notifications for upcoming appointments',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Schedule notification
      await _notifications.zonedSchedule(
        int.parse(appointmentId.replaceAll(RegExp(r'[^0-9]'), '').padLeft(10, '0').substring(0, 10)),
        'Appointment Reminder',
        'You have an appointment with $doctorName in $reminderMinutes minutes',
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: appointmentId,
      );

      debugPrint('Appointment reminder scheduled: $appointmentId at $scheduledDate');
      return true;
    } catch (e) {
      debugPrint('Error scheduling appointment reminder: $e');
      return false;
    }
  }

  /// Schedule multiple reminders for an appointment
  ///
  /// Schedules reminders at 24 hours, 2 hours, and 30 minutes before appointment
  Future<void> scheduleAppointmentReminders({
    required String appointmentId,
    required String doctorName,
    required DateTime appointmentDateTime,
  }) async {
    // 24 hours before
    await scheduleAppointmentReminder(
      appointmentId: '${appointmentId}_24h',
      doctorName: doctorName,
      appointmentDateTime: appointmentDateTime,
      reminderMinutes: 24 * 60,
    );

    // 2 hours before
    await scheduleAppointmentReminder(
      appointmentId: '${appointmentId}_2h',
      doctorName: doctorName,
      appointmentDateTime: appointmentDateTime,
      reminderMinutes: 2 * 60,
    );

    // 30 minutes before
    await scheduleAppointmentReminder(
      appointmentId: '${appointmentId}_30m',
      doctorName: doctorName,
      appointmentDateTime: appointmentDateTime,
      reminderMinutes: 30,
    );
  }

  /// Cancel appointment reminder
  Future<void> cancelAppointmentReminder(String appointmentId) async {
    try {
      // Cancel all related reminders
      final id = int.tryParse(
        appointmentId.replaceAll(RegExp(r'[^0-9]'), '').padLeft(10, '0').substring(0, 10),
      );

      if (id != null) {
        await _notifications.cancel(id);
        await _notifications.cancel(int.parse('${id}_24h'.replaceAll(RegExp(r'[^0-9]'), '').padLeft(10, '0').substring(0, 10)));
        await _notifications.cancel(int.parse('${id}_2h'.replaceAll(RegExp(r'[^0-9]'), '').padLeft(10, '0').substring(0, 10)));
        await _notifications.cancel(int.parse('${id}_30m'.replaceAll(RegExp(r'[^0-9]'), '').padLeft(10, '0').substring(0, 10)));
      }

      debugPrint('Appointment reminder cancelled: $appointmentId');
    } catch (e) {
      debugPrint('Error cancelling appointment reminder: $e');
    }
  }

  /// Cancel all appointment reminders
  Future<void> cancelAllReminders() async {
    try {
      await _notifications.cancelAll();
      debugPrint('All appointment reminders cancelled');
    } catch (e) {
      debugPrint('Error cancelling all reminders: $e');
    }
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      return await _notifications.pendingNotificationRequests();
    } catch (e) {
      debugPrint('Error getting pending notifications: $e');
      return [];
    }
  }

  /// Show immediate notification (for testing)
  Future<void> showTestNotification() async {
    if (!_isInitialized) {
      await initialize();
    }

    const androidDetails = AndroidNotificationDetails(
      'appointments',
      'Appointment Reminders',
      channelDescription: 'Notifications for upcoming appointments',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      999,
      'Test Notification',
      'This is a test notification',
      details,
    );
  }
}

