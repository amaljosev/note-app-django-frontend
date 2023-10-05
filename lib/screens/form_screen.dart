import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tododjango/models/models.dart';
import 'package:tododjango/repositories/api_functions.dart';
import 'package:tododjango/repositories/form_functions.dart';

final formController = Get.put(FormFunctions());
final apiController = Get.find<Api>();

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: TextButton.icon(
                  onPressed: () => addNote(),
                  icon: const Icon(Icons.save, color: Colors.greenAccent),
                  label: const Text(
                    'Save',
                    style: TextStyle(color: Colors.greenAccent),
                  )))
        ],
        title: const Text('New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView(
          children: [
            TextFormField(
              controller: formController.titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
            ),
            TextFormField(
              maxLines: 35,
              controller: formController.descriptionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note',
                hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addNote() {
    final noteObject = Note(
        title: formController.titleController.text,
        description: formController.descriptionController.text);
    apiController.createNote(noteObject);
    
  }
}
