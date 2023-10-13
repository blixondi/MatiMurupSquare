import 'package:flutter/material.dart';
import 'package:project_160420033/screen/mainmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  // runApp(const MainApp());
  runApp(MyMainMenu());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Hello World"
          ),
        ),
      ),
    );
  }
}
