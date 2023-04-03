


import 'package:flutter/material.dart';

class Class2 extends StatefulWidget {
  const Class2({Key? key}) : super(key: key);

  @override
  State<Class2> createState() => _Class2State();
}

class _Class2State extends State<Class2> {
  List<String> year = <String>['2nd master SI', '1st license math', '3rd license si','2nd license informatique'];
  List<String> Class = <String>['redaction siantific', 'app mobile', 'system information','graph theory'];
  List<String> time = <String>['8:00-9:30', '9:30-11:00', '11:00-12:30','2:00-3:30'];
  String username = 'elmasri ahmed';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  PreferredSize(
        preferredSize: const Size(10, 150),
    child: AppBar(
    title: Text(username),
    actions: [
    IconButton(
    onPressed: () {},
    icon: const Icon(Icons.notifications),
    iconSize: 40,
    )
    ],
    toolbarHeight: 150,
    elevation: 0,
    leading: const Padding(
    padding: EdgeInsets.all(8.1),
    child: Material(
    shape: CircleBorder(),
    elevation: 100,
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
    body:  ListView.separated(
    padding: const EdgeInsets.all(10),
    itemCount: Class.length,
    itemBuilder: (BuildContext context, int index) {
    return Container(
    height: 90,

    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Color(0xffecedf6)
    ),
    child: Card(



    child:Row(
    mainAxisAlignment: MainAxisAlignment.start  ,

    children: [
    Container(
    decoration: BoxDecoration(
    color: const Color(0xCA9AE1F6),
    borderRadius: BorderRadius.circular(200)
    ),
    margin: const EdgeInsets.fromLTRB(5,3,5,3),
    child: const SizedBox(
    height: 40,
    width: 40,
    child:Icon(
    Icons.pie_chart_sharp
    ,color: Colors.blueAccent
    ),
    ),
    ),
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
    Container(
    width: 300,
    margin: const EdgeInsets.fromLTRB(15,3,15,3),
    child: Text('${Class[index]}' ,style: const TextStyle(fontSize: 20),)
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    Container(
    margin: const EdgeInsets.fromLTRB(15,3,15,3),
    child: Text('${year[index]}',style: const TextStyle(fontSize: 15),)),
    Container(
    margin: const EdgeInsets.fromLTRB(15,3,15,3),
    child: Text('${time[index]}',
    style:  const TextStyle(color: Color(0xCA29C0EC),
    fontSize: 15,
    )
    )
    )
    ],
    )
    ],

    )
    ],
    )

    ),
    );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(
    height: 10,
    thickness: 0,
    color: Colors.transparent,
    ),
    ));
  }
  }

