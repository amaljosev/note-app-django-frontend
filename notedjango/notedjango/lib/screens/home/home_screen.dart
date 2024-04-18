import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notedjango/models/note_model.dart';
import 'package:notedjango/repositories/functions.dart';
import 'package:notedjango/screens/form/form_screen.dart';
import 'package:notedjango/screens/home/bloc/home_bloc.dart';
import 'package:notedjango/screens/home/widgets/note_card.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

var note = Note(title: '', note: '');

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchNotesEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,
        listener: (context, state) {
          if (state is NavigateToAddState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenForm(isUpdate: false, note: note),
                ));
          } else if (state is DeleteSuccessMessageState) {
            successMessage(context, 'Note Deleted Successfully',true);
          } else if (state is DeleteErrorMessageState) {
            errorMessage(context, 'Deletion failed !!'); 
          } else if (state is UpdateNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ScreenForm(isUpdate: true, note: state.note),
                ));
          }
        },
        builder: (context, state) {
          if (state is FetchNotesSuccessState) {
            return GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(state.notes.length, (index) {
                final noteCard = state.notes[index];
                return NoteCard(noteCard: noteCard); 
              }),
            );
          } else if (state is LoadingNotesState) {
            return const SizedBox.expand(
                child: Center(child: CircularProgressIndicator()));
          } else if (state is FetchNotesErrorState) {
            return const SizedBox.expand(
              child: Center(child: Text('Error')),
            );
          } else {
            return const SizedBox.expand(
              child: Center(child: Text('empty notes')),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomeBloc>().add(NavigateToAddEvent()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
