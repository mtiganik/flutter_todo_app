

import 'package:flutter/material.dart';

class PrioritiesHome extends StatelessWidget{
  const PrioritiesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Priorities", style: TextStyle(color:Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Text("From Priorities home"),
    );

  }

}