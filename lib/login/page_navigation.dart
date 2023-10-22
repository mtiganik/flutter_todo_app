

import 'package:flutter/material.dart';

class PageNavigation extends StatelessWidget{
  const PageNavigation({super.key, required this.title, required this.targetPage});
  final String title;
  final Widget targetPage;
  @override
  Widget build(BuildContext context) {
    return      InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => targetPage
            ));
        },child:  Text( title, 
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline
          )
        )
      );
  }

}