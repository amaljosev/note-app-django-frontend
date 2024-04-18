part of 'home_bloc.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class NavigateToAddState extends HomeActionState {}

final class LoadingNotesState extends HomeState {}

final class FetchNotesSuccessState extends HomeState {
  List<Note> notes = [];
  FetchNotesSuccessState({required this.notes});
}

final class FetchNotesErrorState extends HomeState {}

final class DeleteSuccessMessageState extends HomeActionState {}

final class DeleteErrorMessageState extends HomeActionState {}

final class UpdateNavigationState extends HomeActionState{
Note note;
UpdateNavigationState({required this.note});
}
