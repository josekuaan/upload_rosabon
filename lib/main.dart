import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rosabon/bloc/auth/plan/create_plan_bloc.dart';
import 'package:rosabon/bloc/auth/user/user_bloc.dart';
import 'package:rosabon/firebase_optionssss.dart';
// import 'package:rosabon/firebase_options.dart';
import 'package:rosabon/session_manager/session_manager.dart';
import 'package:rosabon/ui/auth/login_screen.dart';
import 'package:rosabon/ui/auth/onbord.dart';
import 'package:rosabon/ui/auth/reset_password_screen.dart';
import 'package:rosabon/ui/dashboard/dashboard.dart';
import 'package:rosabon/ui/notification/notification.dart';

import 'package:rosabon/ui/views/shared/app_colors.dart';
import 'package:rosabon/ui/views/shared/app_routes.dart';
// import 'package:rosabon/utility/utility.dart';
import 'package:sizer/sizer.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
Future<void> setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id high_importance_channel
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? remoteNotification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (remoteNotification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
        remoteNotification.hashCode,
        remoteNotification.title,
        remoteNotification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails()),
        payload: message.data['body']);
  }
}

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await setupFlutterNotifications();
  await SessionManager().init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "Main Navigator");
  final SessionManager _sessionManager = SessionManager();
  late final FirebaseMessaging _messaging;

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    // await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // if (initialMessage != null) {
    //   PushNotification notification = PushNotification(
    //     title: initialMessage.notification?.title,
    //     body: initialMessage.notification?.body,
    //   );
    // Navigator.pushNamed(context, '/message', arguments: notification);
    // }
  }

  @override
  void initState() {
    super.initState();
    // checkForInitialMessage();
    registerNotification();

    initInfo();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

      print('A new onMessageOpenedApp event was published!');
      print(message.notification);
      print(message.notification);
      print(message.notification);
      navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const AppNotification()));
    });
  }

  initInfo() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          "--------------------------${message.notification?.title}${message.notification?.body}-------------------");
      RemoteNotification remoteNotification = message.notification!;

      // AndroidNotification android = message.notification?.android!;
      flutterLocalNotificationsPlugin.show(
          remoteNotification.hashCode,
          remoteNotification.title,
          remoteNotification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'mipmap/logo1',
              ),
              iOS: const DarwinNotificationDetails()),
          payload: message.data['body']);

      // Navigator.pushNamed(context, AppRouter.notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return OverlaySupport(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreatePlanBloc(),
            ),
            BlocProvider(
              create: (context) => UserBloc(),
            )
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'ROSABON',
            theme:
                ThemeData(primarySwatch: Colors.blue, dividerColor: dustyGray),
            home:
                // const LoginScreen(),

                _sessionManager.loggedInVal
                    ? const LoginScreen()
                    // Dashboard()
                    : const Onboard(),
            routes: AppRouter.routes,
            // initialRoute: AppRouter.splash1,
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
    });
  }
}
