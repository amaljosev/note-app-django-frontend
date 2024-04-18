import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notedjango/models/note_model.dart';
import 'package:notedjango/repositories/api_functions.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, NoteFormState> {
  FormBloc() : super(FormInitial()) {
    on<NoteSaveEvent>(noteSaveEvent);
    on<UpdateNoteEvent>(updateNoteEvent);
  }

  FutureOr<void> noteSaveEvent(
      NoteSaveEvent event, Emitter<NoteFormState> emit) async {
    final isSuccess = await Api().addNote(event.note);
    if (isSuccess) {
      emit(NoteSaveSuccessState());
    } else {
      emit(NoteSaveFailedState());
    }
  }

  FutureOr<void> updateNoteEvent(
      UpdateNoteEvent event, Emitter<NoteFormState> emit) async {
    final isSuccess = await Api().updateNote(event.note, event.id);
    if (isSuccess) {
      emit(NoteUpdateSuccessState());
    } else {
      emit(NoteUpdateErrorState());
    }
  }
}
