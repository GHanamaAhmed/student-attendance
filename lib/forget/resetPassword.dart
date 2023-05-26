import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skoni/signin/signin.dart';
class RestPassword extends StatefulWidget {
  final String email;
  final String code;
  RestPassword(
      {Key? key,required this.email,required this.code})
      : super(key: key);

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  @override
  static var url =
  Uri.parse("https://simpleapi-p29y.onrender.com/users/signup");
  bool passwordvisible = true;
  bool connecting=false;
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
    setState(() {
      connecting = true;
    });
    if (_controller1.text.isEmpty ||
        _controller4.text.isEmpty ||dropdownValue=="") {
      setState(() {
        connecting = false;
      });
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
      setState(() {
        connecting = false;
      });
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
    var respose;
    respose = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/resetPaswword"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": widget.email,
          "rpassword":_controller1.text.toString(),
          "code":widget.code
        });
    var deres = jsonDecode(respose?.body);
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Signin(),
      ),
    );

  }

  bool validatetText(text) {
    return RegExp(r"^[a-zA-Z]+").hasMatch(text);
  }
  int password = 0;
  int resetPasword = 0;
  bool checkbox = false;
  bool selectClick = false;
  String dropdownValue = 'Student';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  child: connecting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                      : const Text("Change password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
