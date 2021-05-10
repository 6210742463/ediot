import 'package:flutter/material.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Diol')),
      drawer: SideMenu(),
    );
  }
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Name Class',
              style: TextStyle(fontSize: 21, color: Colors.blue),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text('Create Content'),
            leading: Icon(Icons.add_circle_outline),
            onTap: () {},
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text('Edit'),
            leading: Icon(Icons.app_registration),
            onTap: () {},
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text('Delete'),
            leading: Icon(Icons.delete),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}