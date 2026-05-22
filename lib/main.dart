import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/editor_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Code Editor',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const EditorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
