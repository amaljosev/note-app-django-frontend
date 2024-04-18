part of 'form_bloc.dart';

abstract class FormEvent {}

abstract class FormActionEvent extends FormEvent {}

final class NoteSaveEvent extends FormActionEvent {
  Note note;
  NoteSaveEvent({required this.note});
}
final class UpdateNoteEvent extends FormActionEvent{
  Note note;
  String id;
  UpdateNoteEvent({required this.note,required this.id});
}

