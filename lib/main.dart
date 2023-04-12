import 'package:flutter/material.dart';
import 'package:skoni/redux/data.dart';
import 'package:skoni/signin/signin.dart';
import 'package:skoni/signup/signup.dart';
import 'package:flutter/services.dart';
import 'package:skoni/student%20ui/student_UI.dart';
import 'package:skoni/teacher%20ui/teacher_UI.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
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
  @override
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
