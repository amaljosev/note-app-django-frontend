import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tododjango/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      title: 'Flutter + Django',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        
      },
    );
  }
}
