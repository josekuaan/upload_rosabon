import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

List<Map<String, dynamic>> months = [
  {"id": 1, "name": "1st"},
  {"id": 2, "name": "2nd"},
  {"id": 3, "name": "3rd"},
  {"id": 4, "name": "4th"},
  {"id": 5, "name": "5th"},
  {"id": 6, "name": "6th"},
  {"id": 7, "name": "7th"},
  {"id": 8, "name": "8th"},
  {"id": 9, "name": "9th"},
  {"id": 10, "name": "10th"},
  {"id": 11, "name": "11th"},
  {"id": 12, "name": "12th"},
  {"id": 13, "name": "13th"},
  {"id": 14, "name": "14th"},
  {"id": 15, "name": "15th"},
  {"id": 16, "name": "16th"},
  {"id": 17, "name": "17th"},
  {"id": 18, "name": "18th"},
  {"id": 19, "name": "19th"},
  {"id": 20, "name": "20th"},
  {"id": 21, "name": "21st"},
  {"id": 22, "name": "22nd"},
  {"id": 23, "name": "23rd"},
  {"id": 24, "name": "24th"},
  {"id": 25, "name": "25th"},
  {"id": 26, "name": "26th"},
  {"id": 27, "name": "27th"},
  {"id": 28, "name": "28th"},
  // {"id": 29, "name": "29th"},
  // {"id": 30, "name": "30th"},
  // {"id": 31, "name": "31st"},
];

class Notifime {
  //  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    FlutterLocalNotificationsPlugin();
    late AndroidNotificationChannel channel;
    var andiodInitilize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInitilize = const DarwinInitializationSettings();

    var initializationSettings =
        InitializationSettings(android: andiodInitilize, iOS: iosInitilize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((payload) {}));

    Future<void> setupFlutterNotifications() async {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      // isFlutterLocalNotificationsInitialized = true;
      // setState(() {
      //   _notificationInfo = notification;
      //   _totalNotifications++;
      // });
    }

    print("=================i Reached here================================");
    setupFlutterNotifications();
    print("=================i Reached here================================");
  }
}
