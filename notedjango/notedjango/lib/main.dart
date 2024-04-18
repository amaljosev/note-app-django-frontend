import 'package:flutter/material.dart';
import 'package:notedjango/screens/form/bloc/form_bloc.dart';
import 'package:notedjango/screens/home/bloc/home_bloc.dart';
import 'package:notedjango/screens/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => FormBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Note App Flutter + Django',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 74, 38, 137)),
          useMaterial3: true,
        ),
        home: const ScreenHome(),
      ),
    );
  }
}
