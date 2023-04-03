import 'package:flutter/material.dart';





class QrGen extends StatefulWidget {
  const QrGen({Key? key}) : super(key: key);

  @override
  State<QrGen> createState() => _QrGenState();
}

class _QrGenState extends State<QrGen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 500,
              height: 500,
              child:Image.asset('assets/images/testqrcode.png') ,

            ),
          )
        ],
      ),
    );
  }
}
