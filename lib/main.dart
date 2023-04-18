import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skoni/redux/data.dart';
import 'package:skoni/signin/signin.dart';
import 'package:skoni/signup/signup.dart';
import 'package:skoni/student%20ui/student_UI.dart';
import 'package:skoni/teacher%20ui/teacher_UI.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /*AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: message.notification!.title,
      body: message.notification!.body,
      category: NotificationCategory.Call,
      wakeUpScreen: true,
      fullScreenIntent: true,
      autoDismissible: true,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'ACCEPT',
        label: 'Accept',
        autoDismissible: false,
      ),
      NotificationActionButton(
        key: 'DECLINE',
        label: 'Decline',
        autoDismissible: false,
      ),
    ],
  );*/
  if(kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  /*AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ],
  );*/
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox("user");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print("Title: ${message.notification!.title} | Body: ${message.notification!.body}");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/signin",
      routes: {
        '/signup': (context) => const Signup(),
        '/signin': (context) => const Signin(),
        '/student ui': (context) => const student_UI(),
        '/teacher ui': (context) => const teacher_UI(),
//        '/teacher ui/home': (context) => Home(),
        //       '/teacher ui/scanner': (context) => QRScannerOverlay(overlayColour: Colors.white30),
      },
    );
  }
}