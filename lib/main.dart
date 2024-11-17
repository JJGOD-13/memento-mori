import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int timeLeftToLive = 0;
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
          child: Center(
            child: Column(
              children: [
                const Text(
                  "You have",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  timeLeftToLive == 0 ? "∞" : "$timeLeftToLive",
                  style: const TextStyle(color: Colors.white, fontSize: 90),
                ),
                const Text(
                  "Days left to live",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (timeLeftToLive != null) {
              setState(() {
                timeLeftToLive++;
              });
            } else {
              setState(() {
                timeLeftToLive = 1;
              });
            }
          },
          child: const Icon(Icons.plus_one),
        ),
      ),
    );
  }
}
