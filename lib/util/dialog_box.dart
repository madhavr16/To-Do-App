import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  VoidCallback onSave;
  VoidCallback onCancel;
  final controller;
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[400],
      content: 
      SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: 
              InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Add a new task",
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                fillColor: Colors.yellow[200],
                filled: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: 'Save', onPressed: onSave),
                MyButton(text: 'Cancel', onPressed: onCancel)
              ],
            )
          ]
          ),
        ),
    );
  }
}