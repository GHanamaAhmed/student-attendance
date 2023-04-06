import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skoni/redux/data.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  State<Person> createState() => _PersonState();
}

String faculte = Student.faculte;
String departement = Student.department;
String specialist = Student.specialist;

class _PersonState extends State<Person> {
  void spl() {
    List<String> words = Student.faculte.split(" ");

    if (words.isNotEmpty) {
      faculte = "${words.first[0]}${words.last[0]}";
    }
    words = Student.department.split(" ");

    if (words.isNotEmpty) {
      departement = "${words.first[0]}${words.last[0]}";
    }
    words = Student.specialist.split(" ");

    if (words.isNotEmpty) {
      specialist = "${words.first[0]}${words.last[0]}";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spl();
    print(Student.faculte);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xeaffffff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("profile",
                style: TextStyle(
                    fontSize: 40, color: Color.fromRGBO(73, 92, 131, 1))),
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(380),
                  border: Border.all(
                      width: 2, color: Color.fromRGBO(204, 204, 204, 1))),
              child: Container(
                child: Image.asset("assets/images/ellipse5.png"),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(204, 204, 204, 1),
                    borderRadius: BorderRadius.circular(380)),
                padding: EdgeInsets.all(15),
                width: 110,
              ),
              margin: EdgeInsets.all(20),
            ),
            Text("${Student.lastName} ${Student.firstName}",
                style: TextStyle(
                    fontSize: 30, color: Color.fromRGBO(73, 92, 131, 1))),
           Container(
             margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
             child:  FractionallySizedBox(
                 widthFactor: 0.9,
                 child: Divider(color: Color.fromRGBO(204, 204, 204, 1)),

           )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(specialist,
                        style: TextStyle(
                            color: Color.fromRGBO(73, 92, 131, 1),
                            fontSize: 17)),
                    Text(
                      "Specialiste",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 204, 204, 1),
                          fontSize: 17),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(departement,
                        style: TextStyle(
                            color: Color.fromRGBO(73, 92, 131, 1),
                            fontSize: 17)),
                    Text(
                      "Departement",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 204, 204, 1),
                          fontSize: 17),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(faculte,
                        style: TextStyle(
                            color: Color.fromRGBO(73, 92, 131, 1),
                            fontSize: 17)),
                    Text(
                      "Faculte",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 204, 204, 1),
                          fontSize: 17),
                    ),
                  ],

                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/images/icon _user octagon.svg",width: 50),
                          Text("User managment",style: TextStyle(color: Color.fromRGBO(73, 92, 131, 1),fontWeight: FontWeight.w500),)
                        ],
                      ),Container(margin: EdgeInsets.fromLTRB(0, 15, 15, 0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/images/logout.svg",width: 50),
                          Text("Logout",style: TextStyle(color: Color.fromRGBO(73, 92, 131, 1),fontWeight: FontWeight.w500),)
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
