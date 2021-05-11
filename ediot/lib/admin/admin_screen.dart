import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ediot/admin/inAdminRoom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'createRoom.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final auth = FirebaseAuth.instance;
  String? n = '', d = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreateRoom();
            }));
          }),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "E-DIOT",
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue[800],
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Subject').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                if (auth.currentUser!.uid.toString() ==
                    document['uid'].toString()) {
                  n = document['name'];
                  d = document['description'];
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminMenu(name: document['name']);
                      }));
                    },
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                          ),
                          title: Text(n!),
                          subtitle: Text(d!),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList(),
            );
          }),
    );
  }
}
