import 'package:flutter/material.dart';
import 'package:memento_mori/src/widgets/home_page.dart';
import 'package:memento_mori/src/widgets/time_picker.dart';
import 'package:memento_mori/src/utils/time_to_live_algo.dart';
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
  int _timeLeftToLive = 0;
  final int _avgDeathAge = 82;
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
      _timeLeftToLive = prefs.getInt('timeLeftToLive') ?? 0;
    });
  }

  Future<void> _saveUserAge(int s) async {
    final pref = await SharedPreferences.getInstance();

    // Convert to correct death time
    var time = timeLeftToLive(s, _avgDeathAge);

    if (time == null) {
      throw Exception("Failed to recieve proper map");
    }

    pref.setInt('timeLeftToLive', time["Days"]!);
    setState(() {
      _timeLeftToLive = s;
    });
  }

  Future<void> _deletepreferences() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    setState(() {
      _timeLeftToLive = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_timeLeftToLive == 0) {
      return MaterialApp(
        home: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              title: const Text("Memento Mori"),
            ),
            backgroundColor: Colors.black,
            body: Center(
              child: TimePicker(
                ageController: _ageController,
                onSubmit: () async {
                  await _saveUserAge(int.parse(_ageController.text));
                  _loadPreferences();
                },
              ),
            ),
          );
        }),
      );
    } else {
      return MaterialApp(
        home: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              title: const Text("Memento Mori"),
            ),
            body: HomePage(timeLeftToLive: _timeLeftToLive),
            floatingActionButton:
                FloatingActionButton(onPressed: () => {_deletepreferences()}),
          );
        }),
      );
    }
  }
}
