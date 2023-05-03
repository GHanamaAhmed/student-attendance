import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skoni/student%20ui/attendence1.dart';
import 'package:skoni/student%20ui/class.dart';
import 'package:skoni/student%20ui/Qrcode.dart';
import 'package:skoni/student%20ui/personal_page.dart';
import 'package:skoni/student%20ui/scanner.dart';
import 'package:flutter_svg/svg.dart';

class student_UI extends StatefulWidget {
  const student_UI({Key? key}) : super(key: key);

  @override
  State<student_UI> createState() => _student_UIState();
}

class _student_UIState extends State<student_UI> {
  int currentPage = 0;
  final List<int> colorCodes = <int>[600, 500, 100];
  final SwiperController _controller = new SwiperController();
  final GlobalKey<NavigatorState> key1 = new GlobalKey<NavigatorState>();
  void _onItemtapped(int index) {
    setState(() {
      currentPage = index;
      key1.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => QRCode(contoller: _controller)),
          (route) => false);
      _controller.move(index);
    });
  }

  var page;
  @override
  void initState() {
    // TODO: implement initState
    page = [
      Class(contoller: _controller),
      const Attendence(),
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/qrcode",
        navigatorKey: key1,
        routes: {
          "/qrcode": (context) => QRCode(contoller: _controller),
          "/scanner": (context) => QRCodeScannerScreen(),
        },
      ),
      const Person(),
    ];
    super.initState();
  }

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
          backgroundColor: Colors.white,
          selectedFontSize: 15,
          iconSize: 25,
          selectedItemColor: const Color.fromRGBO(73, 92, 131, 1),
          onTap: _onItemtapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/images/home1.svg"),
                activeIcon: SvgPicture.asset("assets/images/home.svg"),
                label: 'home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/images/stickynote.svg"),
                activeIcon: SvgPicture.asset("assets/images/stickynote1.svg"),
                label: 'Attendance'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/images/scan.svg"),
                activeIcon: SvgPicture.asset("assets/images/scan1.svg"),
                label: 'scan qr code'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/images/user.svg"),
                activeIcon: SvgPicture.asset("assets/images/user1.svg"),
                label: 'profil')
          ],
        ),
      ),
      body: Swiper(
        itemCount: page.length,
        itemBuilder: (context, index) {
          return page[index];
        },
        loop: false,
        controller: _controller,
        allowImplicitScrolling: true,
        onIndexChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
    );
  }
}
