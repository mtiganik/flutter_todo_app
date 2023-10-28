

class Login{
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  Login({required this.email, required this.password, 
  this.firstName, this.lastName});

  Map<String, dynamic> toJson() => {
    'email' : email,
    'password' : password,
    'firstName' : firstName,
    'lastName' : lastName,
  };
}