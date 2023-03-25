import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  final SwiperController controller;
  ValueNotifier<String> dDvalue;
  ValueNotifier<String> email;
  final Function onChangefirst;
  final Function onChangelast;
  final Function onChangedfaculte;
  final Function onChangeddepatment;
  final Function onChangedspecialist;
  final Function onChangedyear;
  final Function onChangedsex;
  final Function onChangedmodule;

  Page2(
      {Key? key,
      required this.controller,
      required this.dDvalue,
      required this.email,
      required this.onChangeddepatment,
      required this.onChangedfaculte,
      required this.onChangedspecialist,
      required this.onChangedyear,
      required this.onChangefirst,
      required this.onChangelast,
      required this.onChangedsex,
      required this.onChangedmodule})
      : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.dDvalue.addListener(() {
      setState(() {});
    });
    connectF();
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

  Future<dynamic> next() async {
    if ((_controller1.text.isNotEmpty &&
            _controller2.text.isNotEmpty &&
            faculte != "" &&
            department != "" &&
            specialist != "" &&
            academicYear != "" &&
            widget.dDvalue != "" &&
            sex != "") ||
        (_controller1.text.isNotEmpty &&
            _controller2.text.isNotEmpty &&
            widget.dDvalue != "" &&
            sex != "")) {
      setState(() {
        connecting = true;
      });
      var respose;
      if (widget.dDvalue == "Student") {
        respose = await http.post(
            Uri.parse("https://simpleapi-p29y.onrender.com/student/auth"),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              "email": widget.email.value,
            });
      } else {
        respose = await http.post(
            Uri.parse("https://simpleapi-p29y.onrender.com/teacher/auth"),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              "email": widget.email.value,
            });
      }

      var deres = jsonDecode(respose.body);
      setState(() {
        connecting = false;
      });
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
      }
      widget.onChangefirst(_controller1.text.toString());
      widget.onChangelast(_controller2.text.toString());
      widget.onChangedfaculte(faculte);
      widget.onChangeddepatment(department);
      widget.onChangedspecialist(specialist);
      widget.onChangedyear(academicYear);
      widget.onChangedsex(sex);
      widget.onChangedmodule(module);
      widget.controller.next();
    } else {
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Worring'),
                content: Text("Enter all data please"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  )
                ],
              )));
    }
  }

  @override
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final TextEditingController _controller3 = new TextEditingController();
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
  bool isCf = false;
  bool isCD = false;
  bool isCS = false;
  bool connecting = false;
  String faculte = "";
  String specialist = "";
  String academicYear = "";
  String department = "";
  String module = "";
  String sex = "";
  dynamic facultes = null;
  dynamic specialists = ["empty"];
  dynamic departments = null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                                    icon: Icon(Icons.clear),
                                  )
                                : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: _controller1.text.isNotEmpty ||
                                        firstNameClick == false
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Colors.redAccent, width: 2)),
                            border: OutlineInputBorder(
                                borderSide: _controller1.text.isEmpty ||
                                        firstNameClick == true
                                    ? BorderSide(
                                        color: Colors.redAccent, width: 2)
                                    : BorderSide(
                                        color: Colors.blueAccent, width: 2)),
                            filled: true,
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(73, 69, 79, 0.7)),
                            hintText: "first name",
                            fillColor: Color.fromRGBO(245, 245, 245, 0.6)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                    icon: Icon(Icons.clear),
                                  )
                                : null,
                            enabledBorder: OutlineInputBorder(
                                borderSide: _controller2.text.isNotEmpty ||
                                        lastNameClick == false
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Colors.redAccent, width: 2)),
                            border: OutlineInputBorder(
                                borderSide: (_controller1.text.toString() ==
                                            _controller2.text.toString()) ||
                                        lastNameClick == false
                                    ? BorderSide(
                                        color: Colors.blueAccent, width: 2)
                                    : BorderSide(
                                        color: Colors.redAccent, width: 2)),
                            filled: true,
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(73, 69, 79, 0.7)),
                            hintText: "last name",
                            fillColor: Color.fromRGBO(245, 245, 245, 0.6)),
                      ),
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: DropdownButtonFormField<String>(
                onTap: () {
                  setState(() {
                    sexclick = true;
                  });
                },
                isExpanded: true,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: (sexclick == true && sex == "")
                            ? BorderSide(color: Colors.redAccent, width: 2)
                            : BorderSide.none),
                    border: OutlineInputBorder(
                        borderSide: (sexclick == true && sex == "")
                            ? BorderSide(color: Colors.redAccent, width: 2)
                            : BorderSide(color: Colors.blueAccent, width: 2)),
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                    hintText: "sex",
                    filled: true,
                    fillColor: Color.fromRGBO(245, 245, 245, 0.6)),
                // Step 4.
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    sex = newValue!;
                  });
                },
              ),
            ),
            widget.dDvalue.value == "Student"
                ? Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: isCf
                              ? DropdownButtonFormField<String>(
                                  onTap: () {
                                    setState(() {
                                      faculteClick = true;
                                    });
                                  },
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: (faculteClick == true &&
                                                  faculte == "")
                                              ? BorderSide(
                                                  color: Colors.redAccent,
                                                  width: 2)
                                              : BorderSide.none),
                                      border: OutlineInputBorder(
                                          borderSide: (faculteClick == true &&
                                                  faculte == "")
                                              ? BorderSide(
                                                  color: Colors.redAccent,
                                                  width: 2)
                                              : BorderSide(
                                                  color: Colors.blueAccent,
                                                  width: 2)),
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(73, 69, 79, 0.7)),
                                      hintText: "faculte",
                                      filled: true,
                                      fillColor:
                                          Color.fromRGBO(245, 245, 245, 0.6)),
                                  // Step 4.
                                  items: isCf == false
                                      ? null
                                      : facultes.map<DropdownMenuItem<String>>(
                                          (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(fontSize: 15),
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
                                )
                              : null,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: DropdownButtonFormField<String>(
                            onTap: () {
                              setState(() {
                                departmentClick = true;
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: departmentClick == true &&
                                            department == ""
                                        ? BorderSide(
                                            color: Colors.redAccent, width: 2)
                                        : BorderSide.none),
                                border: OutlineInputBorder(
                                    borderSide: departmentClick == true &&
                                            department == ""
                                        ? BorderSide(
                                            color: Colors.redAccent, width: 2)
                                        : BorderSide(
                                            color: Colors.blueAccent,
                                            width: 2)),
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(73, 69, 79, 0.7)),
                                hintText: "department",
                                filled: true,
                                fillColor: Color.fromRGBO(245, 245, 245, 0.6)),

                            // Step 4.
                            items: isCD
                                ? departments.map<DropdownMenuItem<String>>(
                                    (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
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
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                    borderSide: specialistClick == true &&
                                            specialist == ""
                                        ? BorderSide(
                                            color: Colors.redAccent, width: 2)
                                        : BorderSide.none),
                                border: OutlineInputBorder(
                                    borderSide: specialistClick == true &&
                                            specialist == ""
                                        ? BorderSide(
                                            color: Colors.redAccent, width: 2)
                                        : BorderSide(
                                            color: Colors.blueAccent,
                                            width: 2)),
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(73, 69, 79, 0.7)),
                                hintText: "specialist",
                                filled: true,
                                fillColor: Color.fromRGBO(245, 245, 245, 0.6)),

                            // Step 4.
                            items: isCS
                                ? specialists.map<DropdownMenuItem<String>>(
                                    (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
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
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: DropdownButtonFormField<String>(
                            onTap: () {
                              setState(() {
                                academicYearClick = true;
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: academicYearClick == true &&
                                            academicYear == ""
                                        ? BorderSide(
                                            color: Colors.redAccent, width: 2)
                                        : BorderSide.none),
                                border: OutlineInputBorder(
                                    borderSide: academicYearClick == true &&
                                            academicYear == ""
                                        ? BorderSide(
                                            color: Colors.redAccent, width: 2)
                                        : BorderSide(
                                            color: Colors.blueAccent,
                                            width: 2)),
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(73, 69, 79, 0.7)),
                                hintText: "academic year",
                                filled: true,
                                fillColor: Color.fromRGBO(245, 245, 245, 0.6)),

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
                                  style: TextStyle(fontSize: 15),
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
                : Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller3,
                          onChanged: (String? newValue) => setState(() {
                            module = newValue!;
                          }),
                          onTap: () {
                            setState(() {
                              moduleClick = true;
                            });
                          },
                          decoration: InputDecoration(
                              suffixIcon: _controller3.text.length > 0
                                  ? IconButton(
                                      onPressed: () {
                                        _controller3.clear();
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.clear),
                                    )
                                  : null,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      _controller3.text.isEmpty && moduleClick
                                          ? BorderSide(
                                              color: Colors.redAccent, width: 2)
                                          : BorderSide.none),
                              border: OutlineInputBorder(
                                  borderSide:
                                      _controller3.text.isEmpty && moduleClick
                                          ? BorderSide(
                                              color: Colors.redAccent, width: 2)
                                          : BorderSide(
                                              color: Colors.blueAccent,
                                              width: 2)),
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(73, 69, 79, 0.7)),
                              hintText: "module",
                              filled: true,
                              fillColor: Color.fromRGBO(245, 245, 245, 0.6)),
                        )
                      ],
                    ),
                  ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                        onPressed: () => {widget.controller.previous()},
                        child: Text("Prev"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                        onPressed: () => {next()},
                        child: connecting == false
                            ? Text("Next")
                            : Container(
                                height: 20,
                                width: 20,
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
