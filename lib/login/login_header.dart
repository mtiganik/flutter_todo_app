

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginHeader extends StatelessWidget{
  const LoginHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: GoogleFonts.kalam(
        textStyle: const TextStyle(
        height: 2,
        fontSize: 30,
        )
       ));

  }

}