// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginUserModel {
  final String password;
  final String email;
  LoginUserModel({
    required this.password,
    required this.email,
  });
  

  LoginUserModel copyWith({
    String? password,
    String? email,
  }) {
    return LoginUserModel(
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'email': email,
    };
  }

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    return LoginUserModel(
      password: map['password'] as String,
      email: map['email'] as String,
    );
  }

 

  @override
  String toString() => 'LoginUserModel(password: $password, email: $email)';

  @override
  bool operator ==(covariant LoginUserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.password == password &&
      other.email == email;
  }

  @override
  int get hashCode => password.hashCode ^ email.hashCode;
}
