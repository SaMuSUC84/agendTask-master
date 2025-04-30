import 'package:flutter/material.dart';
import 'screens/task_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestiçon de Agenda',
      home: HomeScreen(),
    );
  }
}
