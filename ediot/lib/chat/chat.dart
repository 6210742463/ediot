import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ediot/chat/chat%20appbar.dart';
import 'package:ediot/chat/chat%20detail%20page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chats",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('email').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  if (document['email'] != auth.currentUser!.email!) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatDetailPage(value: document['email']);
                        }));
                      },
                      child: Container(
                        height: 80,
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://static.thenounproject.com/png/630740-200.png"),
                              radius: 25,
                            ),
                            title: Text(document['email']),
                            subtitle: Text(""),
                            trailing: Icon(Icons.message_rounded),
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
      ),
    );
  }
}
