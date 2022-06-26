import 'package:flutter/material.dart';
import 'package:job_bing/emplogin.dart';
import 'package:job_bing/recruitsign.dart';


/// This is the stateful widget that the main application instantiates.
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(       
      child:Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: const Color.fromARGB(249, 255, 254, 254),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    "Choose your role 👇🏻👇🏻",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 60.0),
               child: Row(
                 children: [ 
                   IconButton(
                     icon: const Icon(Icons.person_pin_outlined),
                     splashRadius: MediaQuery.of(context).size.width * 0.1,
                     hoverColor: Colors.blueGrey[100],
                     splashColor: Colors.white,
                     color: Colors.blue,
                     iconSize: MediaQuery.of(context).size.width * 0.2,
                     onPressed: () {
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const Recruitsign()));
                     },
                   ),
                   Text(
                     'Recruiter',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: MediaQuery.of(context).size.width * 0.05,
                   ),
                   ),
                   const Spacer(),
                 ],
               ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 60.0),
              child: Row(
                children: [
                  const Spacer(),
                  IconButton(
                      icon: const Icon(Icons.work_sharp),
                      splashRadius: MediaQuery.of(context).size.width * 0.1,
                      hoverColor: Colors.blueGrey[100],
                      splashColor: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.2,
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LoginPage()));
                      }
                      ),
                  Text(
                    'Employee',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.only(left: 60.0),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.money),
                      splashRadius: MediaQuery.of(context).size.width * 0.1,
                      hoverColor: Colors.blueGrey[100],
                      splashColor: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.deepOrange,
                      alignment: Alignment.topCenter,
                      onPressed: () 
                       {
                      //   Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => const Emp()));
                       }
                      ),
                  Text(
                    'Investor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 60.0, bottom: 40.0),
              child: Row(
                children: [
                  const Spacer(),
                  IconButton(
                      icon: const Icon(Icons.search),
                      splashRadius: MediaQuery.of(context).size.width * 0.1,      
                      hoverColor: Colors.blueGrey[100],
                      splashColor: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.indigo,
                       onPressed: () 
                       {
                      //   Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) =>Book()));
                       }
                       ),
                  Text(
                    'Investor Finder',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ],
              ),
            )
           
          ],
        ),
      ),
      ),
    );
  }
}