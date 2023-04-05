import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Session extends StatefulWidget {
  String idroom;
  Session({Key? key, required this.idroom}) : super(key: key);

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  dynamic data ;
  @override
  void initState() {
    super.initState();
    getattandace();
  }

  dynamic getattandace() async {
    print(widget.idroom);
    var response;
    response = await http.get(
        Uri.parse(
            "https://simpleapi-p29y.onrender.com/student/session/${widget.idroom.toString()}"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        });
    var deresponse;
    deresponse = jsonDecode(response.body);
    if (!deresponse["res"]) {
      return showDialog<String>(
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
              ));
    } else {
      print(deresponse["data"]);
      setState(() {
        data = deresponse["data"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: ListView.separated(
        padding:  EdgeInsets.all(10),
        itemCount: data?.length==null?0:data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 90,
            child: Card(
                /* decoration:  BoxDecoration(
              gradient:const LinearGradient(
                begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  colors: [
                    Color(0xffb9bdc5),
                    Color(0xffe6ebf3)
                  ],
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),*/
                // height: 60,

                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 60,
                  child: Icon(Icons.pie_chart_sharp, color: Colors.blueAccent),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text((index+1).toString()),
                    Text('${data[index]["firstname"]} ${data[index]["lastname"]}'),
                  ],
                )
              ],
            )),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 10,
          thickness: 0,
          color: Colors.transparent,
        ),
      ),
    ));
  }
}
