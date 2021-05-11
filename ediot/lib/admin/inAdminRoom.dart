import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdminMenu extends StatefulWidget {
  String name;
  AdminMenu({Key? key, required this.name}) : super(key: key);

  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset("1.png"),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      onPressed: () {},
                      child: const Text('View'),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: const Text('Edit'),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: const Text('Delete'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('add'),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
