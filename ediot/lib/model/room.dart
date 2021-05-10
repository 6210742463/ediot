import 'dart:convert';

class Room {
  String name;
  String description;
  String uid;
  String imgPath;
  Room({
    this.name = '',
    this.description = '',
    this.uid = '',
    this.imgPath = '',
  });

  Room copyWith({
    String? name,
    String? description,
    String? uid,
    String? imgPath,
  }) {
    return Room(
      name: name ?? this.name,
      description: description ?? this.description,
      uid: uid ?? this.uid,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'uid': uid,
      'imgPath': imgPath,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      name: map['name'],
      description: map['description'],
      uid: map['uid'],
      imgPath: map['imgPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) => Room.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Room(name: $name, description: $description, uid: $uid, imgPath: $imgPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Room &&
        other.name == name &&
        other.description == description &&
        other.uid == uid &&
        other.imgPath == imgPath;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        uid.hashCode ^
        imgPath.hashCode;
  }
}
