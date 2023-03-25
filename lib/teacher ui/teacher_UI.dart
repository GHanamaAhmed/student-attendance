import 'package:flutter/material.dart';

class teacher_UI extends StatefulWidget {
  const teacher_UI({Key? key}) : super(key: key);

  @override
  State<teacher_UI> createState() => _teacher_UIState();
}

class _teacher_UIState extends State<teacher_UI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.class_outlined), label: 'class'),
            NavigationDestination(
                icon: Icon(Icons.qr_code_2_outlined), label: 'scan qr code'),
            NavigationDestination(
                icon: Icon(Icons.person_outlined), label: 'attendence'),
          ],
          backgroundColor: Colors.blue,
        ));
  }
}
