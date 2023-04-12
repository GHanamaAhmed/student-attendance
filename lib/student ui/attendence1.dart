import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../redux/data.dart';

class Attendence extends StatefulWidget {
  const Attendence({Key? key}) : super(key: key);

  @override
  State<Attendence> createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  List<Map<String, dynamic>> teacher = [];
  String time = "";
  var user = Hive.box("user");
  String getTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time = DateFormat.jm().format(dateTime);
    return time;
  }

  dynamic joinroom() async {
    var response = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/attandance"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": user.get("user")!.email,
          "password": user.get("user")!.password,
        });

    var decodedResponse = jsonDecode(response.body);
    setState(() {
      if (decodedResponse["res"] == true) {
        teacher = List<Map<String, dynamic>>.from(decodedResponse["data"]);
      }
    });
  }

  String username = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = "${user.get("user")!.lastName} ${user.get("user")!.firstName}";
    joinroom();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xeaffffff)),
      child: SafeArea(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
                child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Text("Today’s classes",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(73, 92, 131, 1))),
            )),
          ),
          Center(
            child: Column(
              children: teacher
                  .map(
                    (e) => FractionallySizedBox(
                        widthFactor: 0.95,
                        child: Card(
                            child: Container(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xCA9AE1F6),
                                    borderRadius: BorderRadius.circular(200)),
                                margin: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: e['type'] == 'Cour'
                                      ? SvgPicture.asset(
                                          "assets/images/c.svg",
                                        )
                                      : e['type'] == 'Td'
                                          ? SvgPicture.asset(
                                              "assets/images/td.svg")
                                          : e['type'] == "Tp"
                                              ? SvgPicture.asset(
                                                  "assets/images/tp.svg")
                                              : Icon(Icons.pie_chart_sharp,
                                                  color: Colors.blueAccent),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 3, 15, 3),
                                      child: Text('${e["module"]}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(73, 92, 131, 1),
                                            fontSize: 15,
                                          ))),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 3, 15, 3),
                                          child: Text('${e["type"]}',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    73, 92, 131, 1),
                                                fontSize: 15,
                                              ))),
                                      Text("|",
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(73, 92, 131, 1),
                                            fontSize: 15,
                                          )),
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 3, 3, 3),
                                          child: Text(
                                              '${DateFormat('hh:mm a').format(DateTime.parse(e["createAt"]))}',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    73, 92, 131, 1),
                                                fontSize: 15,
                                              )))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ))),
                  )
                  .toList(),
            ),
          ),
        ],
      )),
    );
  }
}
