import 'package:flutter/material.dart';

import 'choose.dart';
import 'forgot.dart';
import 'empsignup.dart';
import 'recruitlog.dart';

class Recruitsign extends StatefulWidget {
  const Recruitsign({Key? key}) : super(key: key);

  @override
  _RecruitsignState createState() => _RecruitsignState();
}
class _RecruitsignState extends State<Recruitsign> {
  String _chosenValue= "Software Tech";
  bool isChecked = false;
  bool valuefirst = false;  
  bool valuesecond = false;  
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                          child: const Text("Welcome to the Recruiter Center",
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
                          "Enter the name of your company",
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
                    "Create a Recruiter Password",
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
                        top: 5.0, right: 20.0, bottom: 10.0, left: 20.0),
                    child: Row(
                      children: const [
                        Text(
                          "Enter your company mail id",
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
                          hintText: "email id",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
                    ),
                  ),

                   Container(
               margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              
              child: Row(
                children: [
                  DropdownButton<String>(
                  
                    iconSize: 25.0,
                    value: _chosenValue,
                    //elevation: 5,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: const TextStyle(color: Colors.black),
                    items: <String>[
                      'Fintech',
                      'Cybersecurity',
                      'Agriculture',
                      'Health and Medicine',
                      'Robotics',
                      'Food and Tech',
                      'Education',
                      'Travel and Tourism',
                      'Media and Entertainment',
                      'Energy and Utilities',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text(
                      "Choose your Company domain",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: ( value) {
                      setState(() {
                        _chosenValue = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
               Container(
                    padding: const EdgeInsets.only(
                        top: 5.0, right: 20.0, bottom: 10.0, left: 20.0),
                    child: Row(
                      children: const [
                        Text(
                          "What kind of employees are you looking for? (separate by comma)",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)))),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Home()));
                      },
                      child: const Text(
                        'Register company',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                   GestureDetector(
                     onTap: () {
                    
                       print("Company Login");
                     
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const Recruitlog()));
                     },
                     child: const Text(
                       "Already registered ? Company Login",
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