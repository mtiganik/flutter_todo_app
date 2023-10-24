import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget{
  const LoginButton({super.key, required this.label, required this.onPressed});
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return         ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(128,45),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            )
          ),
          onPressed: onPressed, 
        child: Text(label, style: const TextStyle(color: Colors.white),));
  }
}