import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScannerScreen extends StatefulWidget {
  @override
  _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isScanning = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Do something with the scan data
      print('scanned  ${scanData.code}');
    });
  }

  void _startScan() {
    setState(() {
      isScanning = true;
    });
  }

  void _stopScan() {
    setState(() {
      isScanning = false;
    });
    controller?.pauseCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner',style: TextStyle(color:Colors.white ,fontSize: 20 )),
        flexibleSpace: Container(
          decoration:const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end:Alignment.centerLeft ,
                  colors: [Color(0xff0066ff), Color(0xff50dbff)]

              )
          ),
        ),
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          if (!isScanning)
            Center(
              child: ElevatedButton(
                onPressed: _startScan,
                child: const Text('Start Scan'),
              ),
            ),
        ],
      ),
      floatingActionButton: isScanning
          ? FloatingActionButton(
        onPressed: _stopScan,
        child: const Icon(Icons.stop),
      )
          : null,
    );
  }
}