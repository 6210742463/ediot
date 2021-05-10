import 'package:ediot/Sign/login.dart';
import 'package:ediot/admin/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text("Profile"),
            backgroundColor: Colors.indigo,
            centerTitle: true),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://static.thenounproject.com/png/630740-200.png"),
                        radius: 100,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      auth.currentUser!.email!,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        child: FlatButton(
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.group,
                            color: Colors.white,
                          ),
                          color: Colors.green[500],
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AdminScreen();
                            }));
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        child: FlatButton(
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text("Logout"),
                          textColor: Colors.white,
                          color: Colors.red[500],
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
