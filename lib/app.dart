// lib/app.dart
import 'package:batch_35d_assignment_2/screens/application_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ApplicationScreen());
  }
}