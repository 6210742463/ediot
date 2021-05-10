import 'package:ediot/Sign/profile.dart';
import 'package:ediot/calendar/calendar.dart';
import 'package:ediot/chat/SelectChat.dart';

import 'package:ediot/elearning/menu.dart';

import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children: [MenuPage(), SelectChat(), CalendarPage(), Profile()],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(child: Image.asset("images/ediot.png")),
              Tab(child: Image.asset("images/chat.png")),
              Tab(child: Image.asset("images/calendar.png")),
              Tab(child: Image.asset("images/menu.png"))
            ],
          ),
        ));
  }
}
