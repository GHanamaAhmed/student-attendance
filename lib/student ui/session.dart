import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:hive/hive.dart';

class Session extends StatefulWidget {
  String idroom;
  Session({Key? key, required this.idroom}) : super(key: key);

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  late IO.Socket socket;
  var user = Hive.box("user");
  dynamic data=[];
  @override
  void initState() {
    getattandace();
    initSocket();
    super.initState();
  }

  initSocket() {
    socket =
        IO.io('https://simpleapi-p29y.onrender.com/rooms', <String, dynamic>{
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
    socket.emit("join-room", {
      "idRoom": widget.idroom,
      "email": user!.get("user")!.email.toString()
    });
    socket.on("join", (res) {
      setState(() {
        data.add(res);
      });
    });
    /*socket.on("message", (data) {
      print(data.toString());
    });*/
    socket.onDisconnect((_) => print('disconnect session'));
    socket.on('fromServer', (_) => print(_));
  }

  dynamic getattandace() async {
    var response;
    response = await http.get(
        Uri.parse(
            "https://simpleapi-p29y.onrender.com/student/session/${widget.idroom.toString()}"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        });
    var deresponse;
    deresponse = jsonDecode(response.body);
    if (!deresponse["res"]) {
      return showDialog<String>(
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
              ));
    } else {
      setState(() {
        data = deresponse["data"];
      });
    }
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
    return SafeArea(
        child: Container(
          color: const Color(0xeaffffff),
      child: Column(
        children: [Center(
            child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Students",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(73, 92, 131, 1))),
                      Text(
                        "${data.length}",
                        style: TextStyle(fontSize: 18,color: Color.fromRGBO(73, 92, 131, 1)),
                      )
                    ],
                  ),
                ))),/*
          ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: data?.length == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 90,
                child: Card(
                    /* decoration:  BoxDecoration(
                  gradient:const LinearGradient(
                    begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      colors: [
                        Color(0xffb9bdc5),
                        Color(0xffe6ebf3)
                      ],
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),*/
                    // height: 60,

                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Icon(Icons.pie_chart_sharp, color: Colors.blueAccent),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text((index + 1).toString()),
                        Text(
                            '${data[index]["firstname"]} ${data[index]["lastname"]}'),
                      ],
                    )
                  ],
                )),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 10,
              thickness: 0,
              color: Colors.transparent,
            ),
          ),*/
          Center(
            child: Column(
              children: data
                  .map<Widget>(
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
                                    borderRadius: BorderRadius.circular(200)),
                                margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child:e["sex"]!="Male"? Image.asset("assets/images/graduating-student.png"):Image.asset("assets/images/ellipse5.png"),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 3, 0, 3),
                                      child: Text('${e["firstname"]} ${e["lastname"]}',
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                                73, 92, 131, 1),
                                            fontSize: 15,
                                          ))),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 3, 15, 3),
                                      child: Text('${e["specialist"]}',
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                                73, 92, 131, 1),
                                            fontSize: 15,
                                          ))),
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
      ),
    ));
  }
}
