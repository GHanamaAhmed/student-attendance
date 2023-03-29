import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:redux/redux.dart';
import 'package:skoni/student%20ui/session.dart';

import '../redux/data.dart';

class QRCodeScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  bool isvalid = false;
  dynamic joinroom(String qrcode) async {
    var respone;
    respone = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/joinroom"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": Student.email.toString(),
          "password": Student.password.toString(),
          "qrcode": qrcode
        });
    var deresponse;
    deresponse = jsonDecode(respone.body);
    if (!deresponse["res"]) {
      controller?.dispose();
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Worring'),
                content: Text(deresponse["mes"]),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  )
                ],
              )));
    } else {
      // await Future.delayed(Duration(seconds: 1));
      isvalid = true;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Session(
                idroom: deresponse["data"]["idRoom"].toString(),
              )));
    }
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late final Store<Student> store;
  QRViewController? controller;
  String qrText = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      setState(() {
        qrText = scanData.code!;
        joinroom(qrText);

        if (isvalid) {
          controller?.stopCamera();
          controller?.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          /* Expanded(
            flex: 1,
            child: Center(
              child: Text('Scanned Text: $qrText'),
            ),
          ),*/
        ],
      ),
    );
  }
}
