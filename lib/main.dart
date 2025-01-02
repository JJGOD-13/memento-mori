import 'package:flutter/material.dart';
import 'package:memento_mori/src/providers/user_age_provider.dart';
import 'package:memento_mori/src/providers/user_display_prefs_provider.dart';
import 'package:memento_mori/src/widgets/home_page.dart';
import 'package:memento_mori/src/widgets/time_picker.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAgeProvider()),
        ChangeNotifierProvider(create: (context) => UserDisplayPrefsProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
        ),
        routes: {
          MementoRoutes.home: (context) => const HomePage(),
          MementoRoutes.input: (context) => TimePicker(),
        },
        initialRoute: MementoRoutes.home,
      ),
    );
  }
}
