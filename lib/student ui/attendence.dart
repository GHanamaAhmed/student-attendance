import 'package:flutter/material.dart';

class attndence extends StatefulWidget {
  const attndence({Key? key}) : super(key: key);

  @override
  State<attndence> createState() => _attndenceState();
}

class _attndenceState extends State<attndence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(10, 150),
          child: AppBar(
            title: const Text('elmasri ahmed'),
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
        body: Container(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffecedf6)),
                child: Card(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xCA9AE1F6),
                          borderRadius: BorderRadius.circular(200)),
                      margin: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.pie_chart_sharp,
                            color: Colors.blueAccent),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(3),
                            child: Text('class: 123' ,
                              style:TextStyle(
                                fontSize: 20
                              ) ,),
                          ),
                        ),

                        Container(
                            width: 300,
                            margin: const EdgeInsets.fromLTRB(15, 3, 15, 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(Icons.close ,
                                  color: Color(0x4cff2424),),
                                Icon(Icons.close,
                                    color: Color(0x4cff2424)),
                                Icon(Icons.close,
                                    color: Color(0x4cff2424))
                              ],
                            )
                        ),
                      ],
                    )
                  ],
                )),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 10,
              thickness: 0,
              color: Colors.transparent,
            ),
            itemCount: 6,
          ),
        ));
  }
}
