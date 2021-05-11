import 'dart:convert';

class Member {
  String email;
  String password;

  Member({
    this.email = '',
    this.password = '',
  });

  Member copyWith({
    String? email,
    String? password,
  }) {
    return Member(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));

  @override
  String toString() => 'Member(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Member &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
