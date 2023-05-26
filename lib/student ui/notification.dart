import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../redux/data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Map<String, dynamic>> teacher = [];
  String time = "";
  late IO.Socket socket;
  var user = Hive.box("user");
  String getTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time = DateFormat.jm().format(dateTime);
    return time;
  }

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
  void dispose() {
    // TODO: implement dispose
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  String username = "";
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      username = "${user.get("user")!.lastName} ${user.get("user")!.firstName}";
      notification();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: const Color(0xeaffffff)),
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                    child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Text("Classes",
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
                        (e) => GestureDetector(
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
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 3),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 3, 15, 3),
                                                  child: Text(
                                                      '${e["type"]}          |',
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            73, 92, 131, 1),
                                                        fontSize: 15,
                                                      ))),
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
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
                                )))),
                      )
                      .toList(),
                ),
              ),
            ],
          )),
        ));
  }
}
