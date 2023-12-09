// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUPUser {
  final String email;
  final String password;
  SignUPUser({
    required this.email,
    required this.password,
  });
  

  SignUPUser copyWith({
    String? email,
    String? password,
  }) {
    return SignUPUser(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory SignUPUser.fromMap(Map<String, dynamic> map) {
    return SignUPUser(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  

  @override
  String toString() => 'SignUPUser(email: $email, password: $password)';

  @override
  bool operator ==(covariant SignUPUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
