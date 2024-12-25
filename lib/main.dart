import 'package:flutter/material.dart';
import 'package:memento_mori/src/utils/enums.dart';
import 'package:memento_mori/src/widgets/home_page.dart';
import 'package:memento_mori/src/widgets/time_picker.dart';
import 'package:memento_mori/src/utils/time_to_live_algo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MementoRoutes {
  static final String home = '/home';
  static final String input = '/input';
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Variables
  Expectancy _expectancy = Expectancy(0, 0, 0, 0);
  final _userDisplayPreference = UserDisplayPreferences.days;
  int _timeLeftToLive = 0;

  // Methods
  @override
  void initState() {
    super.initState();
    _loadPreferences(_userDisplayPreference);
  }

  /// Load any user data from the shared_preferences stored on device.
  /// Takes a [UserDisplayPreferences] enum as input and uses it to decide
  /// which version of the users death day should be returned.
  ///
  /// Example:
  /// _loadPreferences(UserDisplayPreferences.weeks) // Returns users death day in weeks.;
  Future<void> _loadPreferences(
      UserDisplayPreferences displayPreference) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Get the raw json info
      final expectancyString = prefs.getString("timesLeftToLive");

      // Parse the json if it's not null
      if (expectancyString != null) {
        _expectancy = Expectancy.fromJson(jsonDecode(expectancyString));
      }

      // match the displayPreference to the correct value from the json string.
      _timeLeftToLive = switch (displayPreference) {
        UserDisplayPreferences.days => _expectancy.days!,
        UserDisplayPreferences.weeks => _expectancy.weeks!,
        UserDisplayPreferences.months => _expectancy.months!,
        UserDisplayPreferences.years => _expectancy.years!,
      };
    });
  }

  /// Saves the user's age input and calculates their remaining time to live.
  ///
  /// Takes an [age] parameter as an integer and calculates the time left to live
  /// based on the average death age ([_avgDeathAge]).
  ///
  /// The calculated time is stored in SharedPreferences and updates the UI state.
  ///
  /// Throws an [Exception] if the timeLeftToLive calculation returns null.
  ///
  /// Example:
  /// await _saveUserInput(25);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
        ),
        routes: {
          MementoRoutes.home: (context) => const HomePage(),
          MementoRoutes.input: (context) => const TimePicker(),
        },
        home: _timeLeftToLive == 0 ? HomePage() : TimePicker());
  }
}
