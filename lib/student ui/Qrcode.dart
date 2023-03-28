import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRcode extends StatefulWidget {
  const QRcode({Key? key}) : super(key: key);

  @override
  State<QRcode> createState() => _QRcodeState();
}

class _QRcodeState extends State<QRcode> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: GestureDetector(
                onTap: () {
                  setState(() async {

                    Navigator.pushNamed(context, "/teacher ui/scanner");
                  });
                },
                child: SvgPicture.asset(
                  "assets/images/iconscan.svg",
                ),
              ),
            ),
            const Text(
              "OR",
              style: TextStyle(
                  color: Colors.blueAccent, fontSize: 50),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: double.infinity,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: TextFormField(
                  onTap: () {},
                  decoration: const InputDecoration(
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent, width: 2)),
                      filled: true,
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(73, 69, 79, 0.7)),
                      hintText: "Code",
                      fillColor: Colors.white),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    backgroundColor: Colors.white,
                  ),

                  onPressed: () {
                    Navigator.pushNamed(context,'/tests' );
                  },
                  child: const Text(
                    "Scan",
                    style: TextStyle(
                        color: Colors.blueAccent, fontSize: 20),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
