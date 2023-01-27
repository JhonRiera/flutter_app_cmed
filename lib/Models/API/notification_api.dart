// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';

class LocalNotificationService {
  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_stat_local_hospital');

    /*IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );*/

    // ignore: prefer_const_constructors
    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings
      //iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'channel_id', 
            'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true
        );

    /*const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();*/

    return const NotificationDetails(
      android: androidNotificationDetails,
      //iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required int seconds,
      required DateTime scheduleDate}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        DateTime.now().add(Duration(seconds: seconds)),
        tz.local,
      ),
       //_scheduleWeekly(Time(19, 56), days: [DateTime.wednesday]),
      //_scheduleDaily(Time(scheduleDate.hour, scheduleDate.minute)),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

static tz.TZDateTime _scheduleDaily(Time time){   
    final ecuador = tz.getLocation('America/Guayaquil');  
    final now = tz.TZDateTime.now(ecuador);
    var scheduleDate = tz.TZDateTime(tz.getLocation('America/Guayaquil'), now.year, now.month, now.day,
      time.hour, time.minute, time.second);

          /*return scheduleDate.isBefore(now)
          ? scheduleDate.add(Duration(days: 1))
          : scheduleDate; */

      if(scheduleDate.isBefore(now)){
        scheduleDate = scheduleDate.add(const Duration(days: 1));
      }
      return scheduleDate;
  }

  /*static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduleDate = _scheduleDaily(time);

    print(scheduleDate);

    while(!days.contains(scheduleDate.weekday)){
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }

    print(scheduleDate);

    return scheduleDate;
  }*/



  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }

   cancelAll() async => await _localNotificationService.cancelAll();
}
/*class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static Future _notificationDetails() async {
    // ignore: prefer_const_constructors
    return NotificationDetails(
      // ignore: prefer_const_constructors
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        //'channel description',
        importance: Importance.max
      ),
      iOS: const IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false }) async {
    //final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    //final iOS = IOSInitializationSettings();
    //final settings = InitializationSettings(android: android, iOS: iOS);

    /*await _notifications.initialize(
      settings,
      onSelectNotification: (payload) {
        onNotifications.add(payload);
      }, 
    );*/
  
    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async => 
      _notifications.zonedSchedule (
        id,
        title, 
        body, 
        _scheduleWeekly(Time(8, 20), days: [DateTime.wednesday]),
        await _notificationDetails(),  
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: 
          UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
      

  static tz.TZDateTime _scheduleDaily(Time time){   
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
      time.hour, time.minute, time.second);

      return scheduleDate.isBefore(now)
          ? scheduleDate.add(Duration(days: 1))
          : scheduleDate; 
  }

  static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduleDate = _scheduleDaily(time);

    while(!days.contains(scheduleDate.weekday)){
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }
}
*/
