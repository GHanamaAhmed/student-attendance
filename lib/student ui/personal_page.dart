import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skoni/redux/data.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Divider(color: Color.fromRGBO(204, 204, 204, 1)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(Student.specialist.toString(),
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
                    Text(Student.department.toString(),
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
                    Text(Student.faculte.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(73, 92, 131, 1),
                            fontSize: 17)),
                    Text(
                      "Faculte",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 204, 204, 1),
                          fontSize: 17),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
