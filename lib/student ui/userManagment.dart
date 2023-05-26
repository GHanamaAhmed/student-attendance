import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../redux/data.dart';

class UserManagment extends StatefulWidget {
  ValueNotifier<bool> isClick;
  UserManagment({Key? key, required this.isClick}) : super(key: key);

  @override
  State<UserManagment> createState() => _UserManagmentState();
}

class _UserManagmentState extends State<UserManagment> {
  var user = Hive.box("user");
  bool ischange = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isClick.addListener(() {
      if (!ischange) {
        setState(() {
          ischange = true;
          update();
          sleep(const Duration(seconds:2));
          ischange = true;
        });
      }
    });
    connectF();
  }

  Future<dynamic> update() async {
    checked();
    primaryFocus?.unfocus();
    setState(() {
      connecting = true;
    });
    print(user!.get("user")!.password.toString());
    var respose;
    respose = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/update"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": user!.get("user")!.email.toString(),
          "firstname": _controller1.text.toString(),
          "lastname": _controller2.text.toString(),
          "password": _controller.text.toString(),
          "rpassword": _controller3.text.toString(),
          "faculte": faculte,
          "department": department,
          "specialist": specialist,
          "year": academicYear,
        });
    var deres = jsonDecode(respose.body);
    setState(() {
      connecting = false;
    });
    print(deres);
    if (!deres["res"]) {
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Worring'),
                content: Text(deres["mes"]),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  )
                ],
              )));
    } else {
      print(deres["data"]);
      late Student student = new Student(
          firstName: deres["data"]["firstname"].toString(),
          lastName: deres["data"]["lastname"].toString(),
          sex: deres["data"]["sex"].toString(),
          email: deres["data"]["email"].toString(),
          password: deres["data"]["password"].toString(),
          faculte: deres["data"]["faculte"].toString(),
          department: deres["data"]["department"].toString(),
          specialist: deres["data"]["specialist"].toString(),
          year: deres["data"]["year"].toString());
      await user.put("user", student);
      print("ffffffffffffffffffffffffffffffffffffffffffff");
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Worring'),
                content: Text("The change successful"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  )
                ],
              )));
    }
  }

  Future<void> connectF() async {
    var res = await http
        .get(Uri.parse("https://simpleapi-p29y.onrender.com/specialist"));
    var dres = jsonDecode(res.body);
    facultes = dres.map((e) => e["faculte"]);
    facultes = facultes.toString().replaceAll("(", "");
    facultes = facultes.toString().replaceAll(")", "");
    facultes = facultes.toString().replaceAll(", ...", "");
    facultes = facultes.toString().split(", ");
    facultes = facultes.toSet().toList();
    setState(() {
      isCf = true;
    });
  }

  Future<void> connectD() async {
    var res = await http.get(Uri.parse(
        "https://simpleapi-p29y.onrender.com/specialist?f=" + faculte));
    var dres = jsonDecode(res.body);
    departments = dres.map((e) => e["department"]);
    departments = departments.toString().replaceAll("(", "");
    departments = departments.toString().replaceAll(")", "");
    departments = departments.toString().replaceAll(", ...", "");
    departments = departments.toString().split(", ");
    departments = departments.toSet().toList();
    setState(() {
      isCD = true;
    });
  }

  Future<void> connectS() async {
    var res = await http.get(Uri.parse(
        "https://simpleapi-p29y.onrender.com/specialist?f=" +
            faculte +
            "&d=" +
            department));
    var dres = jsonDecode(res.body);
    specialists = dres.map((e) => e["specialist"]);
    specialists = specialists.toString().replaceAll("(", "");
    specialists = specialists.toString().replaceAll(")", "");
    specialists = specialists.toString().replaceAll(", ...", "");
    specialists = specialists.toString().split(", ");
    specialists = specialists.toSet().toList();
    setState(() {
      isCS = true;
    });
  }

  Future<void> checked() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Not connction'),
                content: const Text("Check your conection"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => {
                      setState(() {
                        Navigator.pop(context, 'Cancel');
                        exit(0);
                      })
                    },
                    child: const Text('Exit'),
                  ),
                  TextButton(
                    onPressed: () => {
                      setState(() {
                        Navigator.pop(context, 'Cancel');
                        checked();
                      })
                    },
                    child: const Text('refrech'),
                  ),
                ],
              ));
    }
  }

  @override
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final TextEditingController _controller3 = new TextEditingController();
  bool passwordvisible = true;
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<FormFieldState> _key1 = new GlobalKey();
  final GlobalKey<FormFieldState> _key2 = new GlobalKey();
  bool firstNameClick = false;
  bool lastNameClick = false;
  bool faculteClick = false;
  bool specialistClick = false;
  bool academicYearClick = false;
  bool departmentClick = false;
  bool moduleClick = false;
  bool sexclick = false;
  int password = 0;
  bool isCf = false;
  bool isCD = false;
  bool isCS = false;
  bool connecting = false;
  int resetPasword = 0;
  String faculte = "";
  String specialist = "";
  String academicYear = "";
  String department = "";
  String module = "";
  dynamic facultes = null;
  dynamic specialists = ["empty"];
  dynamic departments = null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: _controller1,
                    onTap: () {
                      setState(() {
                        firstNameClick = true;
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: _controller1.text.length > 0
                            ? IconButton(
                                onPressed: () {
                                  _controller1.clear();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                            borderSide: _controller1.text.isNotEmpty ||
                                    firstNameClick == false
                                ? BorderSide.none
                                : const BorderSide(
                                    color: Colors.redAccent, width: 2)),
                        border: OutlineInputBorder(
                            borderSide: _controller1.text.isEmpty ||
                                    firstNameClick == true
                                ? const BorderSide(
                                    color: Colors.redAccent, width: 2)
                                : const BorderSide(
                                    color: Colors.blueAccent, width: 2)),
                        filled: true,
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(73, 69, 79, 0.7)),
                        hintText: "first name",
                        fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: TextFormField(
                    controller: _controller2,
                    onChanged: (value) => setState(() {}),
                    onTap: () {
                      setState(() {
                        lastNameClick = true;
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: _controller2.text.length > 0
                            ? IconButton(
                                onPressed: () {
                                  _controller2.clear();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                            borderSide: _controller2.text.isNotEmpty ||
                                    lastNameClick == false
                                ? BorderSide.none
                                : const BorderSide(
                                    color: Colors.redAccent, width: 2)),
                        border: OutlineInputBorder(
                            borderSide: (_controller1.text.toString() ==
                                        _controller2.text.toString()) ||
                                    lastNameClick == false
                                ? const BorderSide(
                                    color: Colors.blueAccent, width: 2)
                                : const BorderSide(
                                    color: Colors.redAccent, width: 2)),
                        filled: true,
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(73, 69, 79, 0.7)),
                        hintText: "last name",
                        fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
                  ),
                )),
          ],
        ),
        Container(
          child: TextFormField(
            onTap: () {
              setState(() {
                password = 1;
              });
            },
            controller: _controller,
            obscureText: passwordvisible,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (passwordvisible == true) {
                        passwordvisible = false;
                      } else {
                        passwordvisible = true;
                      }
                    });
                  },
                  icon: Icon(passwordvisible == true
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: _controller.text.length > 7 || password == 0
                        ? BorderSide.none
                        : const BorderSide(color: Colors.redAccent, width: 2)),
                border: OutlineInputBorder(
                    borderSide: _controller.text.length > 7 || password == 0
                        ? const BorderSide(color: Colors.blueAccent, width: 2)
                        : const BorderSide(color: Colors.redAccent, width: 2)),
                filled: true,
                hintStyle:
                    const TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                hintText: "Old password",
                fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
          ),
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        ),
        Container(
          child: TextFormField(
            controller: _controller3,
            obscureText: passwordvisible,
            onTap: () {
              setState(() {
                resetPasword = 1;
              });
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (passwordvisible == true) {
                        passwordvisible = false;
                      } else {
                        passwordvisible = true;
                      }
                    });
                  },
                  icon: Icon(passwordvisible == true
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                                _controller3.text.toString().length>0 ||
                            resetPasword == 0
                        ? BorderSide.none
                        : const BorderSide(color: Colors.redAccent, width: 2)),
                border: OutlineInputBorder(
                    borderSide: _controller3.text.toString().length>0||
                            resetPasword == 0
                        ? const BorderSide(color: Colors.blueAccent, width: 2)
                        : const BorderSide(color: Colors.redAccent, width: 2)),
                filled: true,
                hintStyle:
                    const TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                hintText: "New password",
                fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
          ),
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        ),
        Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: DropdownButtonFormField<String>(
                  onTap: () {
                    setState(() {
                      faculteClick = true;
                    });
                  },
                  isExpanded: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: (faculteClick == true && faculte == "")
                              ? const BorderSide(
                                  color: Colors.redAccent, width: 2)
                              : BorderSide.none),
                      border: OutlineInputBorder(
                          borderSide: (faculteClick == true && faculte == "")
                              ? const BorderSide(
                                  color: Colors.redAccent, width: 2)
                              : const BorderSide(
                                  color: Colors.blueAccent, width: 2)),
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(73, 69, 79, 0.7)),
                      hintText: "faculte",
                      filled: true,
                      fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
                  // Step 4.
                  items: isCf == false
                      ? null
                      : facultes.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      isCD = false;
                      isCS = false;
                      _key2.currentState?.reset();
                    });
                    setState(() {
                      faculte = newValue!;
                      connectD();
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: DropdownButtonFormField<String>(
                  onTap: () {
                    setState(() {
                      departmentClick = true;
                    });
                  },
                  isExpanded: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              departmentClick == true && department == ""
                                  ? const BorderSide(
                                      color: Colors.redAccent, width: 2)
                                  : BorderSide.none),
                      border: OutlineInputBorder(
                          borderSide:
                              departmentClick == true && department == ""
                                  ? const BorderSide(
                                      color: Colors.redAccent, width: 2)
                                  : const BorderSide(
                                      color: Colors.blueAccent, width: 2)),
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(73, 69, 79, 0.7)),
                      hintText: "department",
                      filled: true,
                      fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),

                  // Step 4.
                  items: isCD
                      ? departments
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList()
                      : null,
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      _key1.currentState?.reset();
                      isCS = false;
                    });
                    setState(() {
                      department = newValue!;
                      connectS();
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: DropdownButtonFormField<String>(
                  onTap: () {
                    setState(() {
                      specialistClick = true;
                    });
                  },
                  key: _key1,
                  isExpanded: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              specialistClick == true && specialist == ""
                                  ? const BorderSide(
                                      color: Colors.redAccent, width: 2)
                                  : BorderSide.none),
                      border: OutlineInputBorder(
                          borderSide:
                              specialistClick == true && specialist == ""
                                  ? const BorderSide(
                                      color: Colors.redAccent, width: 2)
                                  : const BorderSide(
                                      color: Colors.blueAccent, width: 2)),
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(73, 69, 79, 0.7)),
                      hintText: "specialist",
                      filled: true,
                      fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),

                  // Step 4.
                  items: isCS
                      ? specialists
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList()
                      : null,
                  onChanged: isCS
                      ? (String? newValue) {
                          setState(() {
                            specialist = newValue!;
                          });
                        }
                      : null,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: DropdownButtonFormField<String>(
                  onTap: () {
                    setState(() {
                      academicYearClick = true;
                    });
                  },
                  isExpanded: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              academicYearClick == true && academicYear == ""
                                  ? const BorderSide(
                                      color: Colors.redAccent, width: 2)
                                  : BorderSide.none),
                      border: OutlineInputBorder(
                          borderSide:
                              academicYearClick == true && academicYear == ""
                                  ? const BorderSide(
                                      color: Colors.redAccent, width: 2)
                                  : const BorderSide(
                                      color: Colors.blueAccent, width: 2)),
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(73, 69, 79, 0.7)),
                      hintText: "academic year",
                      filled: true,
                      fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),

                  // Step 4.
                  items: <String>[
                    'First licence',
                    'Second licence',
                    "Third licence",
                    "First master",
                    "Second master"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      academicYear = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
