import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memento_mori/src/widgets/time_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatter = NumberFormat('#,###');
  int _timeLeftToLive = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memento Mori"),
        centerTitle: false,
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimePicker()),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(90.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center items vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center items horizontally
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
                  _timeLeftToLive == 0
                      ? "∞"
                      : formatter.format(_timeLeftToLive),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "Days left to live",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                // Textfield to take user input.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
