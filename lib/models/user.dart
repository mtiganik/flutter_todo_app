import 'dart:convert';


class User{
  final String token;
  final String refreshToken;
  final String firstName;
  final String lastName;
  User({required this.token, required this.refreshToken,
  required this.firstName, required this.lastName});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      token: json['token'],
      refreshToken: json['refreshToken'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String,dynamic> toJson() => {
    'token': token,
    'refreshToken':refreshToken,
    'firstName':firstName,
    'lastName':lastName
  };
}