import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';
import 'dart:convert';


class QrGen extends StatefulWidget {
  const QrGen({Key? key}) : super(key: key);

  @override
  State<QrGen> createState() => _QrGenState();
}
int x = 4;
String qrData = "https://www.example.com";
String generateRandomString(int length) {
  var random = Random.secure();
  var values = List<int>.generate(length, (i) => random.nextInt(256));
  return base64Url.encode(values);
}
class _QrGenState extends State<QrGen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                  onPressed: () {
                    setState(() {
                      qrData = "https://www.example.com/new ${generateRandomString(7)}";
                    });
                  },
                  child: const Text('generate qr code'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
