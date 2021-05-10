import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ediot/Sign/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CircleAvatar(
                    radius: 50,
                    child: Text("P"),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 11),
                        child: Text(auth.currentUser!.email!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                height: 50,
                minWidth: double.infinity,
                color: Colors.green,
                child: Text("Group"),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Container();
                  }));
                },
              ),
            ),
            Spacer(),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: FlatButton(
                  height: 50,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: Colors.redAccent[700],
                  child: Text("Logout"),
                  textColor: Colors.white,
                  onPressed: () {
                    auth.signOut().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
