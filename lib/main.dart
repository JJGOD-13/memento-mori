import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Memento Mori"),
        ),
        body: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              "Remember that you will die",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        floatingActionButton:
            FloatingActionButton(focusColor: Colors.blue, onPressed: () => 0),
      ),
    );
  }
}
