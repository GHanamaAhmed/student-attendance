import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:skoni/student%20ui/class.dart';
import 'package:skoni/student%20ui/Qrcode.dart';

class student_UI extends StatefulWidget {
  const student_UI({Key? key}) : super(key: key);

  @override
  State<student_UI> createState() => _student_UIState();
}

class _student_UIState extends State<student_UI> {
  int currentPage = 0;
  final List<int> colorCodes = <int>[600, 500, 100];

  void _onItemtapped(int index) {
    setState(() {
      currentPage = index;
      _controller.move(index);
    });
  }

  final SwiperController _controller = new SwiperController();
  var page = [Class(), Home()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xeaffffff),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff0066ff), Color(0xff50dbff)])),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentPage,
          backgroundColor: Colors.transparent,
          selectedFontSize: 15,
          iconSize: 25,
          selectedItemColor: const Color(0xcfe10f0f),
          onTap: _onItemtapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.class_outlined), label: 'class'),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_2_outlined), label: 'scan qr code'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'attendence'),
          ],
        ),
      ),
      body: Swiper(
        itemCount: 3,
        itemBuilder: (context, index) {
          return page[index];
        },
        loop: false,
        controller: _controller,
        allowImplicitScrolling: true,
        onIndexChanged: (value) {
          setState(() {
            currentPage=value;
          });
        },
      ),
    );
  }
}
