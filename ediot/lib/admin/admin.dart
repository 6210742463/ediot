import 'package:flutter/material.dart';
import './addroom_provider.dart';

import 'package:provider/provider.dart';
import './createRoom.dart';
import 'package:ediot/model/room.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return RoomProvider();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminPage(),
      ),
    );
  }
}

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
