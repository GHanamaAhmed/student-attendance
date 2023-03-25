import 'package:flutter/material.dart';

class student_UI extends StatefulWidget {
  const student_UI({Key? key}) : super(key: key);

  @override
  State<student_UI> createState() => _student_UIState();
}

class _student_UIState extends State<student_UI> {
  int currentPage = 0;
  String username = 'elmasri ahmed';
  List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  Widget betterlist(BuildContext context) {
    return ListView.separated(
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
    );
  }

  void _onItemtapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xeaffffff),
      appBar: PreferredSize(
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff0066ff), Color(0xff50dbff)])),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentPage,
          backgroundColor: Colors.transparent,
          selectedFontSize: 15,
          iconSize: 25,
          selectedItemColor: const Color(0xcfe10f0f),
          onTap: _onItemtapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.class_outlined), label: 'class'),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_2_outlined), label: 'scan qr code'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: 'attendence'),
          ],
        ),
      ),
      body: betterlist(context),
    );
  }
}
