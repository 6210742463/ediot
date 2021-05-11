import 'dart:convert';

class SendMessage {
  String email;
  String conversation;
  int index;
  SendMessage({
    this.email = '',
    this.conversation = '',
    this.index = 0,
  });

  SendMessage copyWith({
    String? email,
    String? conversation,
    int? index,
  }) {
    return SendMessage(
      email: email ?? this.email,
      conversation: conversation ?? this.conversation,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'conversation': conversation,
      'index': index,
    };
  }

  factory SendMessage.fromMap(Map<String, dynamic> map) {
    return SendMessage(
      email: map['email'],
      conversation: map['conversation'],
      index: map['index'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMessage.fromJson(String source) =>
      SendMessage.fromMap(json.decode(source));

  @override
  String toString() =>
      'SendMessage(email: $email, conversation: $conversation, index: $index)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SendMessage &&
        other.email == email &&
        other.conversation == conversation &&
        other.index == index;
  }

  @override
  int get hashCode => email.hashCode ^ conversation.hashCode ^ index.hashCode;
}
