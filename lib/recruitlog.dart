import 'package:flutter/material.dart';
import 'package:job_bing/recruitsign.dart';

import 'choose.dart';
import 'forgot.dart';


class Recruitlog extends StatefulWidget {
  const Recruitlog({Key? key}) : super(key: key);

  @override
  _RecruitlogState createState() => _RecruitlogState();
}
class _RecruitlogState extends State<Recruitlog> {
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Scaffold(
      backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 100,
                          child: const Text("Welcome to Recruiter Center",
                          textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ))),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5.0, right: 20.0, bottom: 10.0, left: 20.0),
                    child: Row(
                      children: const [
                        Text(
                          "Company name",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 20.0, bottom: 10.0, left: 20.0),
                    child: Row(
                      children: const [
                        Text(
                          "Company Password",
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
                        top: 10.0, right: 20.0, bottom: 20.0, left: 20.0),
                    child: const TextField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                    ),
                  ),
                  Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Row(
                   children:  [
                     const Spacer(),
                       GestureDetector(
                     onTap: () {
                       print("Create Account");
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const Pass()));
                     },
                     child:const Text(
                         "Forgot Password",
                         style: TextStyle(
                           color: Colors.blue,
                           fontSize: 15.0,
                         ),
                       ),
                       ),
                    ],
                  ),
                ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    width: 200,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 128, 212, 171),
                        borderRadius: BorderRadius.circular(200)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                   GestureDetector(
                     onTap: () {
                    
                       print("Create Account");
                     
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const Recruitsign()));
                     },
                     child: const Text(
                       "New User? Create Account",
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: 20,
                       ),
                     ),
                   ),
                ],
         
        ),
      ),
    ),
    );
  }
}