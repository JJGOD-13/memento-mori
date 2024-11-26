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
  // Variables
  String timeLeftToLive = '';
  final TextEditingController _ageController = TextEditingController();

  // Methods

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: const Text("Memento Mori"),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(90.0),
                child: Column(
                  children: [
                    const Text(
                      "You have",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    // Users time left to live.
                    Text(
                      timeLeftToLive == '' ? "∞" : timeLeftToLive,
                      style: const TextStyle(color: Colors.white, fontSize: 90),
                    ),
                    const Text(
                      "Days left to live",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    // Textfield to take user input.
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Enter Your Age",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      _ageController.clear();
                                    },
                                    icon: const Icon(Icons.clear)),
                                border: const OutlineInputBorder()),
                            controller: _ageController,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: MaterialButton(
                              padding: const EdgeInsets.all(10),
                              onPressed: () {
                                setState(() {
                                  timeLeftToLive =
                                      _ageController.text.toString();
                                  _ageController.clear();
                                });
                              },
                              color: Colors.blue,
                              child: const Text("Set Age"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
