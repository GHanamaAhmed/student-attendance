import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skoni/forget/auth.dart';
import 'package:skoni/forget/resetPassword.dart';
class Auth extends StatefulWidget {
  final String email;
  Auth(
      {Key? key, required this.email})
      : super(key: key);
  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _controller = TextEditingController();
  bool connecting = false;

  dynamic send() async {
    var respose;
    setState(() {
      connecting = true;
    });
    respose = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/forgetpassword"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": widget.email,
          "code":_controller.text.toString()
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RestPassword(email: widget.email, code: _controller.text.toString())));
  }
  dynamic resend() async {
    var respose;
    respose = await http.post(
        Uri.parse("https://simpleapi-p29y.onrender.com/student/authResetPassword"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email": widget.email,
        });
    var deres = jsonDecode(respose?.body);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Authentication",
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Material(
                borderRadius: BorderRadius.circular(8),
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear),
                    )
                        : null,
                    enabledBorder: InputBorder.none,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    hintStyle: TextStyle(
                      color: const Color.fromRGBO(73, 69, 79, 0.7),
                    ),
                    hintText: "Code",
                    filled: true,
                    fillColor: const Color.fromRGBO(245, 245, 245, 0.6),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
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
                      child: const Text(
                        "resend code",
                        style: TextStyle(color: Color.fromRGBO(30, 64, 138, 1)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  onPressed: () {
                    connecting ? null : send();
                  },
                  child: connecting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                      : const Text("Send code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
