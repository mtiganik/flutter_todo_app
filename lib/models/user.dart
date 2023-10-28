import 'dart:convert';


class User{
  final String token;
  final String? refreshToken;
  final String? firstName;
  final String? lastName;
  final String? status;
  User({required this.token,  this.refreshToken,
   this.firstName,  this.lastName,
  this.status});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      token: json['token'],
      refreshToken: json['refreshToken'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      status: json['reasonPhrase']
    );
  }

  Map<String,dynamic> toJson() => {
    'token': token,
    'refreshToken':refreshToken,
    'firstName':firstName,
    'lastName':lastName
  };
}