import 'dart:async';
import 'package:notedjango/models/note_model.dart';
import 'package:notedjango/repositories/api_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NavigateToAddEvent>(navigateToAddEvent);
    on<FetchNotesEvents>(fetchNotesEvents);
    on<DeleteNoteEvent>(deleteNoteEvent);
    on<UpdateNavigationEvent>(updateNavigationEvent);
  }

  FutureOr<void> navigateToAddEvent(
      NavigateToAddEvent event, Emitter<HomeState> emit) {
    emit(NavigateToAddState());
  }

  FutureOr<void> fetchNotesEvents(
      FetchNotesEvents event, Emitter<HomeState> emit) async {
    emit(LoadingNotesState());
    final notes = await Api().getNotes();
    if (notes.isNotEmpty) {
      emit(FetchNotesSuccessState(notes: notes));
    } else {
      emit(FetchNotesErrorState());
    }
  }

  FutureOr<void> deleteNoteEvent(
      DeleteNoteEvent event, Emitter<HomeState> emit) async {
    final isSuccess = await Api().deleteNote(event.id);
    if (isSuccess) {
      emit(DeleteSuccessMessageState());
    } else {
      emit(DeleteErrorMessageState());
    }
  }

  FutureOr<void> updateNavigationEvent(
      UpdateNavigationEvent event, Emitter<HomeState> emit) {
    emit(UpdateNavigationState(note: event.note)); 
  }
}
