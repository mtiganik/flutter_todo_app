

import 'package:flutter/material.dart';

class PasswordConfirmPassword extends StatefulWidget{
  const PasswordConfirmPassword({super.key, required this.labelText, required this.onPasswordChanged, required this.onConfirmPasswordChanged});
  final String labelText;
  final Function(String) onPasswordChanged;
  final Function(String) onConfirmPasswordChanged;
  @override
  State<StatefulWidget> createState() => _PasswordConfirmPasswordState();
  
}

class _PasswordConfirmPasswordState extends State<PasswordConfirmPassword>{
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  bool isPasswordVisible = false;
  String passwordError = 'pwError';

  @override
  void initState(){
    super.initState();
    passwordController.addListener(() { 
      widget.onPasswordChanged(passwordController.text);
    });

    confirmPasswordController.addListener(() {
        widget.onConfirmPasswordChanged(confirmPasswordController.text);
      // if (isValidPassword(confirmPasswordController.text)) {
      // }
      // else {
      //   passwordError = "Password must be 6 letters long, contain uppercase, lowercase letter, a number and a special character";
      // }
    });}

    void togglePasswordVisibility(){
      setState((){
        isPasswordVisible = !isPasswordVisible;
      });
    }

    
    bool isValidPassword(String password) {
    return password.length >= 6 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
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
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              obscureText: !isPasswordVisible,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            GestureDetector(
              onTap: togglePasswordVisibility,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                )
              )
            )
          ],
        ),
        const SizedBox(height: 10,),
        TextField(
          controller: confirmPasswordController,
          obscureText: !isPasswordVisible,
          decoration: const InputDecoration(
            hintText: 'Confirm your password'
          ),
        ),
      ]
    );
  }

  @override
  void dispose(){
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

}