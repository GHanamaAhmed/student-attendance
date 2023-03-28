
import 'package:flutter/material.dart';
import 'package:skoni/signin/signin.dart';
import 'package:skoni/signup/signup.dart';
import 'package:flutter/services.dart';
import 'package:skoni/student%20ui/Qrcode.dart';
import 'package:skoni/student%20ui/scanner.dart';
import 'package:skoni/student%20ui/student_UI.dart';
import 'package:skoni/teacher%20ui/teacher_UI.dart';

void main() {
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

class _MyAppState extends State<MyApp>{

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/student ui",
      routes: {
        '/signup': (context) =>Signup(),
        '/signin': (context) => Signin(),
        '/student ui': (context) => student_UI(),
        '/teacher ui': (context) => teacher_UI(),
        '/scanner': (context) => QrCodeScannerScreen(),
//        '/teacher ui/home': (context) => Home(),
 //       '/teacher ui/scanner': (context) => QRScannerOverlay(overlayColour: Colors.white30),
      },
    );
  }
}
