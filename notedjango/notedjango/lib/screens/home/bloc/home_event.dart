part of 'home_bloc.dart';

abstract class HomeEvent {}

abstract class HomeActionEvent extends HomeEvent {}

final class NavigateToAddEvent extends HomeActionEvent {}

final class FetchNotesEvents extends HomeEvent {}

final class DeleteNoteEvent extends HomeActionEvent {
  String id;
  DeleteNoteEvent({required this.id});
}

final class UpdateNavigationEvent extends HomeActionEvent {
  Note note;
UpdateNavigationEvent({required this.note});
}
