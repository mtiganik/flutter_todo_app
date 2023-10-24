

import 'package:flutter/material.dart';

class NameInput extends StatefulWidget{

  const NameInput({super.key, required this.label, required this.onInputChanged});
  final String label;
  final Function(String) onInputChanged;
  
  @override
  State<StatefulWidget> createState() => _NameInputState();

}

class _NameInputState extends State<NameInput>{
final TextEditingController nameController = TextEditingController();

@override
void initState(){
  super.initState();
  nameController.addListener(() {
    widget.onInputChanged(nameController.text);
  });
}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )),
         TextField(
          controller: nameController,
          
          onChanged: widget.onInputChanged,
          
          decoration: InputDecoration(
            hintText: 'Enter ${widget.label}',
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            
          )
        )
      ],
    );
  }
  @override
  void dispose(){
    nameController.dispose();
    super.dispose();
  }
  
}