

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow, Colors.red],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
        
      ),
      child: const LoginPageBox()
    );
  }
}


class LoginPageBox extends StatelessWidget{
  const LoginPageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return       Container(
      decoration:  BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0)
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(35.0),

      child: const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       Text("Logi666fdsn123"),
        Text("Enter email"),
        Text("Enter passwordfdsfdsfsd")
      ]

    ));
  }
}


class EmailTextInput extends StatefulWidget {
  const EmailTextInput({super.key, required this.labelText, required this.onEmailChanged});

  final String labelText;
  final Function(String) onEmailChanged;


  @override
  State<EmailTextInput> createState() => _EmailTextInputState();
}

class _EmailTextInputState extends State<EmailTextInput> {
  final emailController = TextEditingController();
  bool isEmailValid = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      final email = emailController.text;
      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      final isValid = emailRegex.hasMatch(email);
      if (!isValid) {
        setState(() {
          isEmailValid = false;
        });
      } else {
        setState(() {
          isEmailValid = true;
        });
      }
      widget.onEmailChanged(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            errorText: isEmailValid ? null : 'Invalid email format',
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
