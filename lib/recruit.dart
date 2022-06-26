import 'package:flutter/material.dart';

import 'profile.dart';

class Recruit extends StatefulWidget {
  const Recruit({Key? key}) : super(key: key);

  @override
  _RecruitState createState() => _RecruitState();
}

class _RecruitState extends State<Recruit> {
   int _selectedIndex = 0;  
  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  
  @override
  Widget build(BuildContext context) {
  
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 200.0),
            children: <Widget>[
              const DrawerHeader(
                child: Text('Your Palette',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: const Text('Recruiter Center'),
                onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const Recruit()),
                   );
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Pro()),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Text(
                  "Recruiter Center",
                  style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Container(
              margin: const EdgeInsets.all(10.0),
                child:Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Image(
                          image: NetworkImage('https://s3.amazonaws.com/utep-uploads/wp-content/uploads/sparkle-box/2018/03/22170927/feeling-job-burnout-use-these-work-life-balance-tips-to-reduce-stress-image.jpg'),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Kevin S',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            'Work Experience: NA \n'
                            'Skills: Full Stack Developer, Marketing and Sales'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check on'),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Misso()),
                              // );
                            
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Check Later'),
                            onPressed: () {
                              final snackBar = SnackBar(
                    backgroundColor: const Color.fromARGB(255, 158, 102, 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    duration: const Duration(seconds: 5),
                    content: const Text(
                      "Saved to your checklist",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    action: SnackBarAction(label: 'Undo', onPressed: () {}),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                            
                        
                            
                          ),
                          const SizedBox(width: 8),
                          
                        ],
                      ),
                    ],
                  ),
                  
                ),
                ),
              ),
                
               Container(
                child: Container(
              margin: EdgeInsets.all(10.0),
                child:Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Image(
                          image: NetworkImage('https://images.indianexpress.com/2016/02/employee-working-thinkstock-2.jpg'),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Tony K',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            "Work Experience: 2 years at Microsoft\n"
                            'Skills: Marketing and Sales'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check on'),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Misst()),
                              // );
                            
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Check Later'),
                            onPressed: () {
                              final snackBar = SnackBar(
                    backgroundColor: const Color.fromARGB(255, 158, 102, 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200)),
                    duration: const Duration(seconds: 5),
                    content: const Text(
                      "Saved to your checklist",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    action: SnackBarAction(label: 'Undo', onPressed: () {}),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                            
                        
                            
                          ),
                          const SizedBox(width: 8),
                          
                        ],
                      ),
                    ],
                  ),
                  
                ),
                ),
              ),
              Container(
                child: Container(
              margin: const EdgeInsets.all(10.0),
                child:Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Image(
                          image: NetworkImage('https://media.istockphoto.com/photos/busienssman-stock-image-picture-id1158995697?k=20&m=1158995697&s=612x612&w=0&h=7Woxh4WNm-b1cIc6BvrXFGfe8nPJLLvHFANmyfxye2o='),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Rajkumar N',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            "Work Experience: 1 yr at JioTech\n"
                            "Skills: App Developer"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check on'),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Missth()),
                              // );
                            
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Check Later'),
                            onPressed: () {
                              final snackBar = SnackBar(
                    backgroundColor: const Color.fromARGB(255, 158, 102, 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    duration: const Duration(seconds: 5),
                    content: const Text(
                      "Saved to your checklist",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    action: SnackBarAction(label: 'Undo', onPressed: () {}),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                            
                        
                            
                          ),
                          const SizedBox(width: 8),
                          
                        ],
                      ),
                    ],
                  ),
                  
                ),
                ),
              ),

              Container(
                child: Container(
              margin: const EdgeInsets.all(10.0),
                child:Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Image(
                          image: NetworkImage('https://media.istockphoto.com/photos/profile-picture-of-smiling-indian-female-employee-in-office-picture-id1258168128?k=20&m=1258168128&s=170667a&w=0&h=t0cKJkTS5YMCrdAqsRzHhzsjyfOvJgzrv3LtZyP8BCQ='),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Smrithi K',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            'Work Experience: NA\n'
                            'Skills: Marketing and Sales'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check on'),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Misso()),
                              // );
                            
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Check Later'),
                            onPressed: () {
                              final snackBar = SnackBar(
                    backgroundColor: const Color.fromARGB(255, 158, 102, 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    duration: const Duration(seconds: 5),
                    content: const Text(
                      "Saved to your checklist",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    action: SnackBarAction(label: 'Undo', onPressed: () {}),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                            
                        
                            
                          ),
                          const SizedBox(width: 8),
                          
                        ],
                      ),
                    ],
                  ),
                  
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