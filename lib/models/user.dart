import 'dart:convert';


class User{
  final String token;
  final String? refreshToken;
  final String? firstName;
  final String? lastName;
  final String? statusMessage;
  final int? statusCode;

  User({required this.token,  this.refreshToken,
   this.firstName,  this.lastName,
  this.statusMessage, this.statusCode});

  factory User.fromJson(Map<String, dynamic> json, int statusCode, String statusMessage){
    return User(
      token: json['token'],
      refreshToken: json['refreshToken'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      statusCode: statusCode,
      statusMessage: statusMessage
    );
  }

  Map<String,dynamic> toJson() => {
    'token': token,
    'refreshToken':refreshToken,
    'firstName':firstName,
    'lastName':lastName
  };
}