import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:skoni/student%20ui/notification.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../redux/data.dart';
import 'package:badges/badges.dart' as badge;
import 'package:http/http.dart' as http;

class Class extends StatefulWidget {
  final SwiperController contoller;
  Class({Key? key, required this.contoller}) : super(key: key);

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  late IO.Socket socket;
  int count = 0;
  List<String> entries = <String>['A', 'B', 'C'];
  var user = Hive.box("user");
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      setuserName();
    });
    notification();
    initSocket();
    super.initState();
  }

  String username = "";
  Future<void> setuserName() async {
    print(user.get("user")!.lastName);
    username = "${user.get("user")!.lastName} ${user.get("user")!.firstName}";
  }

  List<Map<String, dynamic>> teacher = [];
  dynamic notification() async {
    print("fffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    var response = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/notification"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": user.get("user")!.email,
          "password": user.get("user")!.password,
        });
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    setState(() {
      if (decodedResponse["res"] == true) {
        teacher = List<Map<String, dynamic>>.from(decodedResponse["data"]);
        teacher = teacher.reversed.toList();
      }
    });
  }

  initSocket() {
    socket =
        IO.io('https://simpleapi-p29y.onrender.com/students', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      "auth": {
        "email": user!.get("user")!.email.toString(),
        "password": user!.get("user")!.password.toString(),
      },
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      print(socket.id);
    });
    socket.emit("join-specialist", {
      "specialist": user.get("user").specialist.toString(),
    });
    socket.on("create-room", (res) {
      setState(() {
        count++;
        notification();
      });
    });
    /*socket.on("message", (data) {
      print(data.toString());
    });*/
    socket.onDisconnect((_) => print('disconnect class'));
    socket.on('fromServer', (_) => print(_));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  String dateFormate(originalTime) {
    // تحويل الوقت إلى كائن DateTime
    DateTime dateTime = DateTime.parse(originalTime);

    // إضافة ساعة واحدة إلى الوقت
    DateTime updatedDateTime = dateTime.add(Duration(hours: 1));

    // تحويل الوقت المحدث إلى التنسيق الجديد
    String formattedTime =
        DateFormat('yyyy-MM-dd   HH:mm').format(updatedDateTime);

    print(formattedTime); // سيظهر الوقت المحدث: 2023-04-23   09:29
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(10, 100),
          child: AppBar(
            title: Text(username),
            toolbarHeight: 100,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.all(8.1),
              child: Image(
                image: user!.get("user")!.sex != "Male"
                    ? AssetImage("assets/images/graduating-student.png")
                    : AssetImage("assets/images/ellipse5.png"),
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff0066ff), Color(0xff50dbff)])),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Center(
                child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Today’s classes",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(73, 92, 131, 1))),
                          GestureDetector(
                            child: Text(
                              "All",
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Notifications()));
                            },
                          ),
                        ],
                      ),
                    ))),
            Center(
              child: Column(
                children: teacher.map((e) {
                  DateTime now = DateTime.now();
                  String formattedNow = DateFormat('yyyy-MM-dd').format(now);
                  DateTime otherDateTime = DateTime.parse(e['date']);
                  String formattedother =
                      DateFormat('yyyy-MM-dd').format(otherDateTime);
                  int comparisonResult = formattedNow.compareTo(formattedother);
                  if (comparisonResult == 0) {
                    return GestureDetector(
                        onTap: () {
                          widget.contoller.move(2);
                        },
                        child: FractionallySizedBox(
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
                                        borderRadius:
                                            BorderRadius.circular(200)),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 3, 0, 3),
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
                                              : SvgPicture.asset(
                                                  "assets/images/tp.svg"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 3, 0, 3),
                                          child: Text('${e["module"]}',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    73, 92, 131, 1),
                                                fontSize: 15,
                                              ))),
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 3, 0, 3),
                                          child: Text('${e["name"]}',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    73, 92, 131, 1),
                                                fontSize: 15,
                                              ))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 3, 15, 3),
                                              child: Text('${e["type"]}          |',
                                                  style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        73, 92, 131, 1),
                                                    fontSize: 15,
                                                  ))),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 3, 3, 3),
                                              child: Text(
                                                  '${dateFormate(e["date"])}',
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
                            ))));
                  }
                  return Container();
                }).toList(),
              ),
            ),
          ],
        )));
  }
}
