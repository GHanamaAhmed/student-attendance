import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:redux/redux.dart';
import 'package:skoni/student%20ui/session.dart';
import '../redux/data.dart';

class QRCodeScannerScreen extends StatefulWidget {
  QRCodeScannerScreen({super.key});

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
    if (deresponse["res"] == true) {
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
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      setState(() async {
        qrText = scanData.code!;
        joinroom(qrText);
        await Future.delayed(Duration(seconds: 2));
        if (isvalid) {
          controller?.stopCamera();
          controller?.dispose();
        }else{
          controller.resumeCamera();
        }
      });
    });
    await controller.resumeCamera();
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
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
              ),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }
}
