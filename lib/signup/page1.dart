import 'dart:io';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class Page1 extends StatefulWidget {
  final SwiperController contoller;
  final Function onChangedemail;
  final Function onChangedpassword;
  Page1(
      {Key? key, required this.contoller,required this.onChangedemail,required this.onChangedpassword})
      : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  static var url =
      Uri.parse("https://simpleapi-p29y.onrender.com/users/signup");
  bool passwordvisible = true;
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller4 = new TextEditingController();
  bool validateEmail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
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
    primaryFocus?.unfocus();
    if (_controller.text.isEmpty ||
        _controller1.text.isEmpty ||
        _controller4.text.isEmpty ||dropdownValue=="") {
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
    } else if (_controller1.text.toString() != _controller4.text.toString()) {
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Worring'),
                content: Text("Enter the same password"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  )
                ],
              )));
    }
    widget.onChangedemail(_controller.text.toString());
    widget.onChangedpassword(_controller1.text.toString());
    widget.contoller.next();
    /*showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    var respose = await http.post(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      "firstname": _controller2.text.toString(),
      "lastname": _controller3.text.toString(),
      "email": _controller.text.toString(),
      "password": _controller1.text.toString()
    });
    var deres = jsonDecode(respose.body);
    Navigator.of(context).pop();
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
    }*/
  }

  bool validatetText(text) {
    return RegExp(r"^[a-zA-Z]+").hasMatch(text);
  }

  int emailClick = 0;
  int password = 0;
  int resetPasword = 0;
  bool checkbox = false;
  bool selectClick = false;
  String dropdownValue = 'Student';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: _controller,
                onChanged: (value) => setState(() {}),
                onTap: () {
                  setState(() {
                    emailClick = 1;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: _controller.text.length > 0
                        ? IconButton(
                            onPressed: () {
                              _controller.clear();
                              setState(() {});
                            },
                            icon: Icon(Icons.clear),
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                        borderSide: validateEmail(
                                    _controller.text.toString()) ||
                                emailClick == 0
                            ? BorderSide.none
                            : BorderSide(color: Colors.redAccent, width: 2)),
                    border: OutlineInputBorder(
                        borderSide: validateEmail(
                                    _controller.text.toString()) ||
                                emailClick == 0
                            ? BorderSide(color: Colors.blueAccent, width: 2)
                            : BorderSide(color: Colors.redAccent, width: 2)),
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                    hintText: "Email",
                    filled: true,
                    fillColor: Color.fromRGBO(245, 245, 245, 0.6)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                onTap: () {
                  setState(() {
                    password = 1;
                  });
                },
                controller: _controller1,
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
                        borderSide: _controller1.text.length > 7 ||
                                password == 0
                            ? BorderSide.none
                            : BorderSide(color: Colors.redAccent, width: 2)),
                    border: OutlineInputBorder(
                        borderSide: _controller1.text.length > 7 ||
                                password == 0
                            ? BorderSide(color: Colors.blueAccent, width: 2)
                            : BorderSide(color: Colors.redAccent, width: 2)),
                    filled: true,
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                    hintText: "Password",
                    fillColor: Color.fromRGBO(245, 245, 245, 0.6)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: _controller4,
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
                        borderSide: (_controller1.text.toString() ==
                                    _controller4.text.toString()) ||
                                resetPasword == 0
                            ? BorderSide.none
                            : BorderSide(color: Colors.redAccent, width: 2)),
                    border: OutlineInputBorder(
                        borderSide: (_controller1.text.toString() ==
                                    _controller4.text.toString()) ||
                                resetPasword == 0
                            ? BorderSide(color: Colors.blueAccent, width: 2)
                            : BorderSide(color: Colors.redAccent, width: 2)),
                    filled: true,
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                    hintText: "Reset password",
                    fillColor: Color.fromRGBO(245, 245, 245, 0.6)),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                onPressed: () => {
                setState(() {
                  next();
                })
                },
                child: Text("Next"),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't you have account?",
                    style: TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/signin");
                      },
                      child: new Text(
                        "Sign in",
                        style: TextStyle(color: Color.fromRGBO(30, 64, 138, 1)),
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
