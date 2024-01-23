import 'package:flutter/material.dart';
import 'package:notepad/Bouton.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;


  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nouvelle tâche",
              ),

            ),
            Row(
              children: [
                Bouton(
                  text: "Save",
                  onPressed: onSave,
                ), // bouton save
                Bouton(
                  text: "Annuler",
                  onPressed: onCancel,
                ), // bouton annuler
              ],
            ),
          ],
        ),
      ),
    );
  }
}
