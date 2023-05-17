import 'package:flutter/material.dart';

import './screens/auth_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.indigo.shade400,
              background: Colors.indigo,
              secondary: Colors.amber,
            ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          foregroundColor: Colors.indigo,
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
