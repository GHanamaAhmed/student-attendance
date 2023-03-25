import 'package:flutter/material.dart';
class Class extends StatefulWidget {
  const Class({Key? key}) : super(key: key);

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  List<String> entries = <String>['A', 'B', 'C'];
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
        itemCount: entries.length,
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

                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start  ,

                  children: [
                    const SizedBox(
                      width: 60,
                      child:Icon(
                          Icons.pie_chart_sharp
                          ,color: Colors.blueAccent
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('teacher name '),
                        Text('class name'),
                        Text('time')
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
      ),
    );
  }
}
