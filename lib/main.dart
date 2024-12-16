import 'package:flutter/material.dart';
import 'package:memento_mori/src/widgets/home_page.dart';
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
    setState(() {
      timeLeftToLive = s;
    });
  }

  Future<void> _deletepreferences() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    setState(() {
      timeLeftToLive = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timeLeftToLive == "") {
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
                  await _savePreferences(_ageController.text);
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
            body: HomePage(timeLeftToLive: timeLeftToLive),
            floatingActionButton:
                FloatingActionButton(onPressed: () => {_deletepreferences()}),
          );
        }),
      );
    }
  }
}
