

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
  final confirmPasswordFocusNode = FocusNode();
  bool isPasswordVisible = false;
  bool isValidPassword = true;
  bool isValidConfirmPassword = true;
  @override
  void initState(){
    super.initState();
    passwordController.addListener(() {
        widget.onPasswordChanged(passwordController.text);
    });

    confirmPasswordController.addListener(() {
        widget.onConfirmPasswordChanged(confirmPasswordController.text);
    });

    passwordFocusNode.addListener(() {
      if(!passwordFocusNode.hasFocus){
        final currPw = passwordController.text;
        final isValid = validatePassword(currPw);
        if(isValid){
          setState(() {
            isValidPassword = true;
          });
        }else {
          setState(() {
            isValidPassword = false;
          });
        }
      }
    });

    confirmPasswordFocusNode.addListener(() {
      if(passwordController.text == confirmPasswordController.text){
        setState(() {
          isValidConfirmPassword = true;
        });
      }else{
        setState(() {
          isValidConfirmPassword = false;
        });
      }
    });

    }


    void togglePasswordVisibility(){
      setState((){
        isPasswordVisible = !isPasswordVisible;
      });
    }

    
    bool validatePassword(String password) {
    return password.length >= 6 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#\$%^&*()+,.?":{}|<>]'));
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
              decoration: InputDecoration(
                hintText: 'Enter your password',
                errorText: isValidPassword ? null : "upper/lowercase letter, number and special character needed",
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
          focusNode: confirmPasswordFocusNode,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Confirm your password',
            errorText: isValidConfirmPassword ? null : "Confirm must match password",
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