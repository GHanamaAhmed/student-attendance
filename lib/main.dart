
import 'package:flutter/material.dart';
import 'package:skoni/signin/signin.dart';
import 'package:skoni/signup/signup.dart';
import 'package:flutter/services.dart';
import 'package:skoni/student%20ui/student_UI.dart';
import 'package:skoni/teacher%20ui/teacher_UI.dart';
import 'package:skoni/student ui/scanner.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/scanner",
      routes: {
        '/signup': (context) =>const Signup(),
        '/signin': (context) => const Signin(),
        '/student ui': (context) => const student_UI(),
        '/teacher ui': (context) => const teacher_UI(),
        '/scanner': (context) => const QRCodeScannerScreen(),
//        '/teacher ui/home': (context) => Home(),
 //       '/teacher ui/scanner': (context) => QRScannerOverlay(overlayColour: Colors.white30),
      },
    );
  }
}
