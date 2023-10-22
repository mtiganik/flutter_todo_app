


import 'package:flutter/material.dart';

class PasswordTextInput extends StatefulWidget {
  const PasswordTextInput({super.key, required this.labelText, required this.onPasswordChanged});
  final String labelText;
  final Function(String) onPasswordChanged;


  @override
  State<PasswordTextInput> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      widget.onPasswordChanged(passwordController.text);
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0,15,0,15),
      child: Column(
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
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
