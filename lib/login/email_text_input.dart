import 'package:flutter/material.dart';

class EmailTextInput extends StatefulWidget {
  const EmailTextInput({super.key, required this.labelText, required this.onEmailChanged});

  final String labelText;
  final Function(String) onEmailChanged;


  @override
  State<EmailTextInput> createState() => _EmailTextInputState();
}

class _EmailTextInputState extends State<EmailTextInput> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
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
    emailFocusNode.addListener(() {
      if(!emailFocusNode.hasFocus){
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


      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Container(
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
        TextField(
          controller: emailController,
          focusNode: emailFocusNode,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            errorText: isEmailValid ? null : 'Invalid email format',
          ),
        ),
      ],
    ));
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
