import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ediot/admin/createRoom.dart';
import 'package:ediot/elearning/learnning.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffffffff),
          title: Text(
            "E-DIOT",
            style: TextStyle(fontSize: 30, color: Colors.blue[800]),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[900],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateRoom();
          }));
        },
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
              return Card(
                child: Row(
                  children: [
                    Text(
                      document['name'],
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Learnning();
                        }));
                      },
                      child: Image.network(
                        document['imgPath'],
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
