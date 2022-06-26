import 'package:flutter/material.dart';
import 'package:job_bing/finder.dart';
import 'package:job_bing/findlog.dart';

class Findsign extends StatefulWidget {
  const Findsign({Key? key}) : super(key: key);

  @override
  _FindsignState createState() => _FindsignState();
}

class _FindsignState extends State<Findsign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (
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
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height*0.2,
                    child: const Text("Welcome to Investor Finder",
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
                    "Enter your Full Name",
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
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "username",
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
                    "Enter your Email Id",
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
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email id",
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
                    "Enter your Password",
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
                    "Enter your Startup Name",
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
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)))),
              ),
            ),
            Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(200)),
              // ignore: deprecated_member_use
              child: TextButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      backgroundColor: const Color.fromARGB(255, 148, 224, 151),
                      title: const Text('Details Confirmed',
                      style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 25.0 ,
                          ),
                      ),
                      content: const Text('Get ready to find your investor',
                      style: TextStyle(
                           fontSize: 25.0 ,
                          ),
                      ),
                      actions: <Widget>[
                        
                        TextButton(
                          onPressed: () {
                            // Navigator.pop(context, 'OK');
                            Navigator.push(
                       context, MaterialPageRoute(builder: (context) => const Finder()));
                          },
                          child: const Text('Yes🔫',
                          style: TextStyle(
                           fontStyle: FontStyle.italic,
                           fontSize: 20.0 ,
                           color: Colors.black,
                          ),
                        ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'No');
                          },
                          child: const Text('No🙅',
                          style: TextStyle(
                           fontStyle: FontStyle.italic,
                           fontSize: 20.0 ,
                           color: Colors.black,
                          )
                          ),
                        ),
                      ],
                    ),
                  );

                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: const Text('Register',
                    style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                print("Log In");
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Findlog()));
              },
              child: const Text(
                "Already registered? Log In",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
