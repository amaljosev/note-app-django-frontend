
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notedjango/models/note_model.dart';
import 'package:notedjango/screens/home/bloc/home_bloc.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.noteCard});
  final Note noteCard;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      final  note = noteCard;
        return context.read<HomeBloc>().add(UpdateNavigationEvent(note: note));
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        noteCard.title.toString().toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () => context
                            .read<HomeBloc>() 
                            .add(DeleteNoteEvent(id: noteCard.id.toString())), 
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade600,
                        ))
                  ],
                ),
                Flexible(
                    child: Text(
                  noteCard.note.toString(),
                  overflow: TextOverflow.fade,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
