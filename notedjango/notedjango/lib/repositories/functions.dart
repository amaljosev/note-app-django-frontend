import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notedjango/screens/home/bloc/home_bloc.dart';

void errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }

  void successMessage(BuildContext context,String message,bool isDelete) {
   isDelete?'' :Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
    ));
    context.read<HomeBloc>().add(FetchNotesEvents());
  }