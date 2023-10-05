import 'package:flutter/material.dart';
import 'package:tododjango/models/models.dart';
import 'package:tododjango/screens/form_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.snapshot,required this.id});
  final snapshot;
  final id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    super.initState();
    formController.titleController.text = widget.snapshot.title;
    formController.descriptionController.text = widget.snapshot.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: TextButton.icon(
                  onPressed: () => updateNote(),
                  icon: const Icon(Icons.update, color: Colors.greenAccent),
                  label: const Text(
                    'Update',
                    style: TextStyle(color: Colors.greenAccent),
                  )))
        ],
        title: const Text('Update Note'),
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

  updateNote() {
    final note = Note(
        title: formController.titleController.text,
        description: formController.descriptionController.text); 
    apiController.updateNote(note,widget.id); 
  }
  
}
