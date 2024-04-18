part of 'form_bloc.dart';

abstract class NoteFormState {}

abstract class FormActionState extends NoteFormState {}

final class FormInitial extends NoteFormState {}

final class NoteSaveSuccessState extends FormActionState {}

final class NoteSaveFailedState extends FormActionState {}

final class NoteUpdateSuccessState extends FormActionState {}

final class NoteUpdateErrorState extends FormActionState {}
