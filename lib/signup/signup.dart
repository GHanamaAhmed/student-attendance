import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skoni/signup/page1.dart';
import 'package:skoni/signup/page2.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:skoni/signup/page3.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pages = [
      Page1(
        contoller: _controller,
        onChangedropDownValue: (value) {
          setState(() {
            dDvalue.value = value;
          });
        },
        onChangedemail: (value) {
          email.value = value;
        },
        onChangedpassword: (value) {
          password.value = value;
        },
      ),
      Page2(
        controller: _controller,
        dDvalue: dDvalue,
        onChangedmodule: (value) {
          module.value = value;
        },
        onChangedsex: (value) {
          sex.value = value;
        },
        email: email,
        onChangeddepatment: (value) {
          department.value = value;
        },
        onChangedfaculte: (value) {
          faculte.value = value;
        },
        onChangedspecialist: (value) {
          spcialist.value = value;
        },
        onChangefirst: (value) {
          first.value = value;
        },
        onChangedyear: (value) {
          year.value = value;
        },
        onChangelast: (value) {
          last.value = value;
        },
      ),
      Page3(
        dDvalue: dDvalue,
        sex: sex,
        email: email,
        d: department,
        f: faculte,
        first: first,
        last: last,
        p: password,
        s: spcialist,
        year: year,
        m: module,
      )
    ];
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    offset = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(controller);
    controller.forward();
  }

  final SwiperController _controller = new SwiperController();
  ValueNotifier<String> dDvalue = ValueNotifier<String>('');
  ValueNotifier<String> email = ValueNotifier<String>('');
  ValueNotifier<String> password = ValueNotifier<String>('');
  ValueNotifier<String> faculte = ValueNotifier<String>('');
  ValueNotifier<String> department = ValueNotifier<String>('');
  ValueNotifier<String> spcialist = ValueNotifier<String>('');
  ValueNotifier<String> year = ValueNotifier<String>('');
  ValueNotifier<String> first = ValueNotifier<String>('');
  ValueNotifier<String> last = ValueNotifier<String>('');
  ValueNotifier<String> sex = ValueNotifier<String>('');
  ValueNotifier<String> module = ValueNotifier<String>('');
  var pages;
  bool con = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SlideTransition(
            position: offset,
            child: Swiper(
              itemCount: 3,
              itemBuilder: (context, index) {
                return pages[index];
              },
              loop: false,
              controller: _controller,
              allowImplicitScrolling: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ));
  }
}
