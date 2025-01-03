import 'package:flutter/material.dart';
import 'package:memento_mori/src/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDisplayPrefsProvider extends ChangeNotifier {
  UserDisplayPreferences userDisplayPreference;

  UserDisplayPrefsProvider({
    this.userDisplayPreference = UserDisplayPreferences.days,
  }) {
    loadUserDisplay();
  }

  /// Load display preference from SharedPreferences
  Future<void> loadUserDisplay() async{
    final prefs = await SharedPreferences.getInstance();
    String? savedPref = prefs.getString('userDisplayPreference');
    if (savedPref != null) {
      userDisplayPreference = UserDisplayPreferences.values.firstWhere(
        (e) => e.toString() == savedPref,
        orElse: () => UserDisplayPreferences.days,
      );
      notifyListeners();
    }
  }

  Future<void> setUserDisplayPref({required UserDisplayPreferences newPref}) async{
    userDisplayPreference = newPref;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userDisplayPreference', newPref.toString());
    notifyListeners();
  }
}
