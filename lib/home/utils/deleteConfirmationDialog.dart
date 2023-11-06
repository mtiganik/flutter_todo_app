
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget{
  final String title;
  final String content;

  const DeleteConfirmationDialog({super.key, required this.title, required this.content});

  @override
  Widget build(context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
                actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm
              },
              child: const Text('Delete'),
            ),
          ],

    );
  }

}
