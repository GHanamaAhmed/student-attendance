import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:skoni/student%20ui/userManagment.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  ValueNotifier<bool> isClick = ValueNotifier<bool>(false);
  var user = Hive.box("user");
  late String faculte;
  late String departement;
  late String specialist;
  void spl() {
    setState(() {
      List<String> words = faculte.split(" ");

      if (words.isNotEmpty&&faculte.indexOf(" ")>=0) {
        faculte = "${words.first[0]}${words.last[0]}";
      }else{
        faculte = "${words.first[0]}";
      }
      words = departement.split(" ");

      if (words.isNotEmpty&&departement.indexOf(" ")>=0) {
        departement = "${words.first[0]}${words.last[0]}";
      }else{
        departement = "${words.first[0]}";
      }
      words = specialist.split(" ");

      if (words.isNotEmpty&&specialist.indexOf(" ")>0) {
        specialist = "${words.first[0]}${words.last[0]}";
      }else{
        specialist = "${words.first[0]}";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      faculte = user.get("user")!.faculte;
      departement = user.get("user")!.department;
      specialist = user.get("user")!.specialist;
    });

    spl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xeaffffff),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("profile",
                style: TextStyle(
                    fontSize: 40, color: Color.fromRGBO(73, 92, 131, 1))),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(380),
                  border: Border.all(
                      width: 2, color: const Color.fromRGBO(204, 204, 204, 1))),
              margin: const EdgeInsets.all(20),
              child: Container(
                child: user!.get("user")!.sex != "Male"
                    ? Image.asset("assets/images/graduating-student.png")
                    : Image.asset("assets/images/ellipse5.png"),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(204, 204, 204, 1),
                    borderRadius: BorderRadius.circular(380)),
                padding: const EdgeInsets.all(15),
                width: 110,
              ),
            ),
            Text("${user.get("user")!.lastName} ${user.get("user")!.firstName}",
                style: const TextStyle(
                    fontSize: 30, color: Color.fromRGBO(73, 92, 131, 1))),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Divider(color: Color.fromRGBO(204, 204, 204, 1)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(specialist,
                        style: const TextStyle(
                            color: Color.fromRGBO(73, 92, 131, 1),
                            fontSize: 17)),
                    const Text(
                      "Specialty",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 204, 204, 1),
                          fontSize: 17),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(departement,
                        style: const TextStyle(
                            color: Color.fromRGBO(73, 92, 131, 1),
                            fontSize: 17)),
                    const Text(
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
                        style: const TextStyle(
                            color: Color.fromRGBO(73, 92, 131, 1),
                            fontSize: 17)),
                    const Text(
                      "Faculty",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 204, 204, 1),
                          fontSize: 17),
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                              "assets/images/icon _user octagon.svg",
                              width: 50),
                          GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          scrollable: true,
                                          title:
                                              const Text('Exit confirmation'),
                                          content:
                                              UserManagment(isClick: isClick),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isClick.value
                                                      ? isClick.value = false
                                                      : isClick.value = true;
                                                  isClick.value =
                                                      !isClick.value;
                                                });
                                              },
                                              child: const Text('Update'),
                                            )
                                          ],
                                        ));
                              },
                              child: const Text(
                                "User management",
                                style: TextStyle(
                                    color: Color.fromRGBO(73, 92, 131, 1),
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                      Container(margin: const EdgeInsets.fromLTRB(0, 15, 15, 0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/images/logout.svg",
                              width: 50),
                          GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title:
                                              const Text('Exit confirmation'),
                                          content: const Text("Do you want to exit?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('NO'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                user.delete("user");
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        "/signin",
                                                        (route) => false);
                                              },
                                              child: const Text('Yes'),
                                            )
                                          ],
                                        ));
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                    color: Color.fromRGBO(73, 92, 131, 1),
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
