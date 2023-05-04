import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:skoni/student%20ui/student_UI.dart';
import 'package:hive/hive.dart';
import '../redux/data.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
   var user = Hive.box("user");
  Future<void> checked() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        con = true;
      }
    } on SocketException catch (_) {
      con = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoSignIn();
    });

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    offset = Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
        .animate(controller);
    controller.forward();
  }

  bool passwordvisible = true;
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller1 = new TextEditingController();
  bool validateEmail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  dynamic signin() async {
    primaryFocus?.unfocus();
    checked();
    emailClick = 1;
    password = 1;
    if (_controller.text.isEmpty || _controller1.text.isEmpty) {
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Worring'),
                content: const Text("enter all data"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  )
                ],
              )));
    }
    setState(() {
      connecting = true;
    });
    var respone;
    respone = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/teacher/signin"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": _controller.text.toString(),
          "password": _controller1.text.toString()
        });
    var deresponse;
    deresponse = jsonDecode(respone.body);
    if (!deresponse["res"]) {
      respone = await http.post(
          Uri.parse("https://simpleapi-p29y.onrender.com/student/signin"),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            "email": _controller.text.toString(),
            "password": _controller1.text.toString()
          });
      deresponse = jsonDecode(respone.body);
      setState(() {
        connecting = false;
      });
      if (!deresponse["res"]) {
        return (showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Worring'),
                  content: Text(deresponse["mes"]),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    )
                  ],
                )));
      } else {
        setState(() {
          connecting = false;
        });


        late Student student = new Student(
            firstName: deresponse["data"]["firstname"].toString(),
            lastName: deresponse["data"]["lastname"].toString(),
            sex: deresponse["data"]["sex"].toString(),
            email: deresponse["data"]["email"].toString(),
            password: deresponse["data"]["password"].toString(),
            faculte: deresponse["data"]["faculte"].toString(),
            department: deresponse["data"]["department"].toString(),
            specialist: deresponse["data"]["specialist"].toString(),
            year: deresponse["data"]["year"].toString());
        await user.put("user", student);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const student_UI()));
      }
    } else {
      setState(() {
        connecting = false;
      });
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Sign in'),
                content: const Text("succssful"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  )
                ],
              )));
    }
  }

  void autoSignIn() {
    if (user.get("user")!=null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const student_UI()));
    }
  }

  bool validatetText(text) {
    return RegExp(r"^[a-zA-Z]+").hasMatch(text);
  }

  int emailClick = 0;
  int password = 0;
  bool checkbox = false;
  bool connecting = false;
  bool con = true;
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: offset,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      onTap: () {
                        setState(() {
                          emailClick = 1;
                        });
                      },
                      controller: _controller,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                          suffixIcon: _controller.text.length > 0
                              ? IconButton(
                                  onPressed: () {
                                    _controller.clear();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: validatetText(
                                          _controller.text.toString()) ||
                                      emailClick == 0 ||
                                      validateEmail(_controller.text.toString())
                                  ? const BorderSide(
                                      color: Colors.blueAccent, width: 2)
                                  : const BorderSide(
                                      color: Colors.redAccent, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: validatetText(
                                          _controller.text.toString()) ||
                                      emailClick == 0 ||
                                      validateEmail(_controller.text.toString())
                                  ? BorderSide.none
                                  : const BorderSide(
                                      color: Colors.redAccent, width: 2)),
                          filled: true,
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(73, 69, 79, 0.7)),
                          hintText: "Username or Email",
                          fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                              borderSide:
                                  _controller1.text.length > 7 || password == 0
                                      ? BorderSide.none
                                      : const BorderSide(
                                          color: Colors.redAccent, width: 2)),
                          border: OutlineInputBorder(
                              borderSide:
                                  _controller1.text.length > 7 || password == 0
                                      ? const BorderSide(
                                          color: Colors.blueAccent, width: 2)
                                      : const BorderSide(
                                          color: Colors.redAccent, width: 2)),
                          filled: true,
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(73, 69, 79, 0.7)),
                          hintText: "Password",
                          fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Checkbox(
                                value: checkbox,
                                onChanged: (value) {
                                  setState(() {
                                    if (checkbox == true) {
                                      checkbox = false;
                                    } else {
                                      checkbox = true;
                                    }
                                  });
                                },
                              ),
                              const Text(
                                "Save account",
                                style: TextStyle(
                                    color: Color.fromRGBO(73, 69, 79, 0.7)),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: new Text(
                              "Forget password?",
                              style: const TextStyle(
                                  color: Color.fromRGBO(73, 69, 79, 0.7)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                      onPressed: () {
                        signin();
                      },
                      child: connecting == false
                          ? const Text("Sign in")
                          : Container(
                              height: 20,
                              width: 20,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't you have account?",
                          style:
                              TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/signup");
                            },
                            child: new Text(
                              "Sign up",
                              style: const TextStyle(
                                  color: Color.fromRGBO(30, 64, 138, 1)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
