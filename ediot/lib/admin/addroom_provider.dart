import 'package:flutter/foundation.dart';
import 'package:ediot/model/room.dart';

class RoomProvider with ChangeNotifier {
  List<Room> room = [];

  List<Room> getRoom() {
    return room;
  }

  void addRoom(Room statement) {
    room.add(statement);
    notifyListeners();
  }
}
