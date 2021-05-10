import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectChat extends StatefulWidget {
  @override
  _SelectChat createState() => _SelectChat();
}

class _SelectChat extends State<SelectChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
            title: Text(
              "Chats",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {},
              ),
            ]),
        body: Column(
          children: <Widget>[
            Container(height: 90, color: Colors.blue[900]),
          ],
        ));
  }
}
