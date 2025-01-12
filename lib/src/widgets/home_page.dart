import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memento_mori/src/providers/user_age_provider.dart';
import 'package:memento_mori/src/providers/user_display_prefs_provider.dart';
import 'package:memento_mori/src/utils/time_to_live_algo.dart';
import 'package:memento_mori/src/widgets/memento_app_bar.dart';
import 'package:memento_mori/src/widgets/memento_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    var usrAge = context.watch<UserAgeProvider>().userAge;
    var usrExpectancy = timeLeftToLive(
        usrAge, context.watch<UserAgeProvider>().genericDeathDay);
    var usrDispPref =
        context.watch<UserDisplayPrefsProvider>().userDisplayPreference;
    var displayString = Casing.titleCase(usrDispPref.name);
    var usrTimeLeftToLive = usrExpectancy?.fromDisplayPref(usrDispPref);

    return Scaffold(
      appBar: MementoAppBar(
        renderSettings: true,
      ),
      drawer: MementoDrawer(),
      //floatingActionButton: ElevatedButton(
      //  onPressed: () {
      //    Navigator.push(
      //        context, MaterialPageRoute(builder: (context) => TimePicker()));
      //  },
      //  child: Icon(
      //    Icons.add,
      //    color: Colors.white,
      //  ),
      //),
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
                  usrTimeLeftToLive == 0
                      ? "∞"
                      : formatter.format(usrTimeLeftToLive),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "$displayString left to live",
                  textAlign: TextAlign.center,
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
