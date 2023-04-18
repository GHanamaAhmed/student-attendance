import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../redux/data.dart';
import 'package:badges/badges.dart' as badge;

class Class extends StatefulWidget {
  const Class({Key? key}) : super(key: key);

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
    initSocket();
    super.initState();
  }

  String username = "";
  Future<void> setuserName() async {
    print(user.get("user")!.lastName);
    username = "${user.get("user")!.lastName} ${user.get("user")!.firstName}";
  }

  List<Map<String, String>> teacher = <Map<String, String>>[
    {
      "name": 'ghanama',
      "class": "redaction siantific",
      "time": "8:00-9:30",
      "type": "c"
    },
    {
      "name": 'elmasri',
      "class": 'app mobile',
      "time": '9:30-11:00',
      "type": "td"
    },
    {
      "name": 'abellache',
      "class": 'system information',
      "time": '11:00-12:30',
      "type": "tp"
    },
    {
      "name": 'moulay lkhader',
      "class": 'graph theory',
      "time": '2:00-3:30',
      "type": "td"
    },
  ];
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
        print(res);
        count++;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(10, 100),
          child: AppBar(
            title: Text(username),
            actions: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Center(
                  child: badge.Badge(
                    position: badge.BadgePosition.topEnd(top: 5, end: 3),
                    badgeStyle: badge.BadgeStyle(
                        padding: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(10),
                        badgeColor:
                            count == 0 ? Colors.transparent : Colors.red),
                    badgeContent: count != 0
                        ? Text("${count}",
                            style: TextStyle(color: Colors.white))
                        : Text(""),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          count = 0;
                        });
                      },
                      icon: const Icon(Icons.notifications,
                          color: Colors.white, size: 40),
                    ),
                  ),
                ),
              )
            ],
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
        body: Column(
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
                          Text(
                            "All",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ))),
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
                                  margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: e['type'] == 'c'
                                        ? SvgPicture.asset(
                                            "assets/images/c.svg",
                                          )
                                        : e['type'] == 'td'
                                            ? SvgPicture.asset(
                                                "assets/images/td.svg")
                                            : SvgPicture.asset(
                                                "assets/images/tp.svg"),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 3, 0, 3),
                                        child: Text('${e["class"]}',
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  73, 92, 131, 1),
                                              fontSize: 15,
                                            ))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                15, 3, 15, 3),
                                            child: Text('${e["name"]}',
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      73, 92, 131, 1),
                                                  fontSize: 15,
                                                ))),
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                15, 3, 3, 3),
                                            child: Text('${e["time"]}',
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
        ));
  }
}
