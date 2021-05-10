import 'package:flutter/material.dart';

class AdminMenu extends StatefulWidget {
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
                Image.asset('images/IU.jpg'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'test description',
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
