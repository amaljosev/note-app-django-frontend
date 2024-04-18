import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notedjango/models/note_model.dart';
import 'package:notedjango/screens/form/bloc/form_bloc.dart';
import 'package:notedjango/repositories/functions.dart';

final titleController = TextEditingController();
final noteController = TextEditingController();

class ScreenForm extends StatefulWidget {
  const ScreenForm({super.key, required this.note, required this.isUpdate});
  final bool isUpdate;
  final Note note;

  @override
  State<ScreenForm> createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> {
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note.title.toString();
      noteController.text = widget.note.note.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.text = '';
    noteController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormBloc, NoteFormState>(
      listenWhen: (previous, current) => current is FormActionState,
      buildWhen: (previous, current) => current is! FormActionState,
      listener: (context, state) {
        if (state is NoteSaveSuccessState) {
          successMessage(context,'Note Added Successfully',false);
        }  else if (state is NoteSaveFailedState) {
          errorMessage(context,'Note not added!!');
        } else if (state is NoteUpdateSuccessState) {
          successMessage(context,'Note Updated Successfully',false);
        } else if (state is NoteUpdateErrorState) {
          errorMessage(context,'Note not Updated ');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.isUpdate ? 'Update Note' : 'New Note'),
            actions: [
              widget.isUpdate
                  ? TextButton.icon(
                      onPressed: () => updateNote(context),
                      icon: const Icon(Icons.update),
                      label: const Text('Update'),
                    )
                  : TextButton.icon(
                      onPressed: () => saveNote(context),
                      icon: const Icon(Icons.save),  
                      label: const Text('Save'),
                    )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.border_color_rounded, size: 20),
                        hintText: 'Title',
                        hintStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                    ),
                    TextFormField(
                      maxLines: 35,
                      controller: noteController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note',
                        hintStyle: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

 void saveNote(BuildContext context) {
    final title = titleController.text;
    final note = noteController.text;
    final noteObject = Note(title: title, note: note);
    context.read<FormBloc>().add(NoteSaveEvent(note: noteObject));
  }

 void updateNote(BuildContext context) {
    final title = titleController.text;
    final note = noteController.text;
    final noteObject = Note(title: title, note: note);
    context
        .read<FormBloc>()
        .add(UpdateNoteEvent(note: noteObject, id: widget.note.id.toString()));
  }



  
}
