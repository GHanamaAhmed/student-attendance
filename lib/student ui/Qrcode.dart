import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:hive/hive.dart';
import 'package:skoni/student%20ui/session.dart';
class QRCode extends StatefulWidget {
  final SwiperController contoller;
  QRCode({Key? key, required this.contoller}) : super(key: key);
  @override
  State<QRCode> createState() => _QRCodeState();
}
class _QRCodeState extends State<QRCode> with TickerProviderStateMixin {
  dynamic joinroom(String qrcode) async {
    var user =await Hive.box("user");
    var respone;
    respone = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/joinCode"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": user.get("user")!.email,
          "password":user.get("user")!.password,
          "code":code
        });
    var deresponse;
    deresponse = jsonDecode(respone.body);
    if (deresponse["res"] == true) {
      // await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Session(
            idroom: deresponse["data"]["idRoom"].toString(),
          )));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Code invalid")));
    }
  }
  String code="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xeaffffff),
        body: Center(
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: GestureDetector(
                    onTap: () {
                      setState(() async {
                        Navigator.of(context).pushNamed("/scanner");
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/images/iconscan.svg",
                    ),
                  ),
                ),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 50),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: double.infinity,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                      onTap: () {},
                      decoration: InputDecoration(
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2)),
                          filled: true,
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(73, 69, 79, 0.7)),
                          hintText: "Code",
                          fillColor: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            joinroom(code);
                          });
                        },
                        child: Text(
                          "Scan",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
