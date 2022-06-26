import 'package:flutter/material.dart';

import 'choose.dart';


class Pass extends StatefulWidget {
  const Pass({Key? key}) : super(key: key);

  @override
  _PassState createState() => _PassState();
}

class _PassState extends State<Pass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
            child: Center(
              child: Container(
                  width: 700,
                  height: 50,
                  child: const Text("Password Changer", 
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ))),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 10.0, right: 20.0, bottom: 10.0, left: 20.0),
            child: Row(
              children: const [
                Text(
                  "Enter new password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 10.0, right: 20.0, bottom: 10.0, left: 20.0),
            child: const TextField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)))),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 10.0, right: 20.0, bottom: 10.0, left: 20.0),
            child: Row(
              children: const [
                
                Text(
                  "Re-enter password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 10.0, right: 20.0, bottom: 10.0, left: 20.0),
            child: const TextField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)))),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
            width: 200,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(200)),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
