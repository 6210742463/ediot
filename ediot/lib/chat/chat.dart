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
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      body: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              child: Text("back"),
                              color: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
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
                      title: Text("Name"),
                      subtitle: Text(""),
                      trailing: Icon(Icons.message_rounded),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
