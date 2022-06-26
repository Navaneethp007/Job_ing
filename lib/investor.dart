import 'package:flutter/material.dart';

import 'profile.dart';

class Investor extends StatefulWidget {
  const Investor({Key? key}) : super(key: key);

  @override
  _InvestorState createState() => _InvestorState();
}

class _InvestorState extends State<Investor> {
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
          backgroundColor: const Color.fromARGB(246, 240, 237, 237),
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
                title: const Text('Investor Center'),
                onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const Investor()),
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
                  "Investor Center",
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
                          image: NetworkImage('https://pbs.twimg.com/profile_images/1162023249066115072/az3MRDMX_400x400.jpg'),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Agrivator',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            'We aim to bring a change in the field of agriculture by efficient combination \n'
                            'of technologies like artificial intelligence with IOT and modern farming techniques.'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check out'),
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
                      "Saved to your investment list",
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
                          image: NetworkImage('https://media-exp1.licdn.com/dms/image/C4D0BAQH3Gzg7l18xFA/company-logo_200_200/0/1629729370599?e=2147483647&v=beta&t=D6MSA1lAT34kYDVa59iEeK9mkvV0YMdya3tt-8SnLEQ'),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Luova Foundation',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            "Luova Foundation, India's 1st technical design community for women is a women based.\n"
                            'educational startup community for the upliftment of women in various technical design fields'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check out'),
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
                      "Saved to your investment list",
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
                          image: NetworkImage('http://companies.naukri.com/euctopeoplenew-dev/wp-content/uploads/sites/35073/2021/02/logo-web.png'),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Eucto',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            "If Business Transformation is what you’re looking for, you’re looking at the right place.\n"
                            "You name it, we’d have done it and if you’re lucky, we’d do it for you too."),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check out'),
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
                      "Saved to your investment list",
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
                          image: NetworkImage('https://media-exp1.licdn.com/dms/image/C4E0BAQFVGdMkOMrByA/company-logo_200_200/0/1521143135039?e=2147483647&v=beta&t=jmPy1IxH0CFnmVtPODreh08Y7sElGK4C-Rw-QuLrCbM'),
                          width: 70,
                          height: 70,
                        ),
                        
                        title: Text('Autobot India',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        subtitle: Text(
                            'Autobota India is a Emobility startup company building innovative solutions \n'
                            'for technology experience, adoption and development.'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child:  const Text('Check out'),
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
                      "Saved to your investment list",
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
