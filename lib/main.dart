import 'package:flutter/material.dart';
import 'package:memento_mori/src/widgets/time_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      timeLeftToLive = prefs.getString('timeLeftToLive') ?? "";
    });
  }

  Future<void> _savePreferences(String s) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString('timeLeftToLive', s);
  }

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
                  mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
                  crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
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
                    TimePicker(
                      _ageController: _ageController,
                      onSubmit: () => _savePreferences(_ageController.text),
                    )
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