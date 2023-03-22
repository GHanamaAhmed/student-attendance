import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/services.dart';

class Page3 extends StatefulWidget {
  ValueNotifier<String> dDvalue;
  ValueNotifier<String> sex;
  ValueNotifier<String> email;
  ValueNotifier<String> p;
  ValueNotifier<String> f;
  ValueNotifier<String> d;
  ValueNotifier<String> s;
  ValueNotifier<String> first;
  ValueNotifier<String> last;
  ValueNotifier<String> year;
  ValueNotifier<String> m;

  Page3(
      {Key? key,
      required this.email,
      required this.d,
      required this.f,
      required this.first,
      required this.last,
      required this.p,
      required this.s,
      required this.year,
      required this.dDvalue,
      required this.sex,
      required this.m})
      : super(key: key);

  @override
  State<Page3> createState() => _Page1State();
}

class _Page1State extends State<Page3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.email.addListener(() {
      setState(() {});
    });
    widget.first.addListener(() {
      setState(() {});
    });
    widget.last.addListener(() {
      setState(() {});
    });
    widget.f.addListener(() {
      setState(() {});
    });
    widget.s.addListener(() {
      setState(() {});
    });
    widget.d.addListener(() {
      setState(() {});
    });
    widget.year.addListener(() {
      setState(() {});
    });
    widget.p.addListener(() {
      setState(() {});
    });
    widget.sex.addListener(() {
      setState(() {});
    });
    widget.dDvalue.addListener(() {
      setState(() {});
    });
    widget.m.addListener(() {
      setState(() {});
    });
  }

  Future<dynamic> resend() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    var respose;
    if (widget.dDvalue == "Student") {
      respose = await http.post(
          Uri.parse("https://simpleapi-p29y.onrender.com/student/reauth"),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            "email": widget.email.value,
          });
    } else {
      respose = await http.post(
          Uri.parse("https://simpleapi-p29y.onrender.com/teacher/reauth"),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            "email": widget.email.value,
          });
    }

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
    }
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

  Future<dynamic> signup() async {
    checked();
    primaryFocus?.unfocus();
    setState(() {
      connecting = true;
    });
    var respose;
    if (widget.dDvalue.value == "Student") {
      respose = await http.post(
          Uri.parse("https://simpleapi-p29y.onrender.com/student/signup"),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            "firstname": widget.first.value,
            "lastname": widget.last.value,
            "sex": widget.sex.value,
            "email": widget.email.value,
            "password": widget.p.value,
            "faculte": widget.f.value,
            "department": widget.d.value,
            "specialist": widget.s.value,
            "year": widget.year.value,
            "code": _controller.text.toString()
          });
    } else {
      respose = await http.post(
          Uri.parse("https://simpleapi-p29y.onrender.com/teacher/signup"),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            "firstname": widget.first.value,
            "lastname": widget.last.value,
            "sex": widget.sex.value,
            "email": widget.email.value,
            "password": widget.p.value,
            "specialist": widget.m.value,
            "code": _controller.text.toString()
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
    } else {
      return (showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Complete'),
                content: const Text("succssful"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                      Navigator.pop(context, "/signup");
                      Navigator.pushNamed(context, "/signin");
                    },
                    child: const Text('Cancel'),
                  )
                ],
              )));
    }
  }

  bool connecting = false;
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
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
                    "Authentication",
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  )
                ],
              ),
            ),
            Container(
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
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
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2)),
                    hintStyle:
                        const TextStyle(color: Color.fromRGBO(73, 69, 79, 0.7)),
                    hintText: "Code",
                    filled: true,
                    fillColor: const Color.fromRGBO(245, 245, 245, 0.6)),
              ),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          resend();
                        });
                      },
                      child: new Text(
                        "resend code",
                        style: const TextStyle(
                            color: Color.fromRGBO(30, 64, 138, 1)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                onPressed: () => signup(),
                child: connecting == false
                    ? Text("Sign up")
                    : SizedBox(
                        height: 20,
                        width: 20,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
