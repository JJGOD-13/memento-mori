// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:memento_mori/src/providers/user_display_prefs_provider.dart';
import 'package:memento_mori/src/utils/time_to_live_algo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAgeProvider extends ChangeNotifier {
  int userAge = 0;
  int genericDeathDay = 80;

  UserAgeProvider({
    this.userAge = 0,
  }) {
    loadUserAge();
  }

  /// Load user's age from SharedPreferences
  Future<void> loadUserAge() async {
    final prefs = await SharedPreferences.getInstance();
    userAge = prefs.getInt('userAge') ?? 0;
    notifyListeners();
  }

  /// Save user's age to SharedPreferences
  Future<void> setUserAge({required int newAge}) async {
    userAge = newAge;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userAge', newAge);
    notifyListeners();
  }

  int getUserExpectancy() {
    var user_display_pref_prov = UserDisplayPrefsProvider();
    var user_display_pref = user_display_pref_prov.userDisplayPreference;
    var age = userAge;
    try {
      var time_left_to_live = timeLeftToLive(age, genericDeathDay);
      return time_left_to_live!.fromDisplayPref(user_display_pref);
    } catch (e) {
      return 6969;
    }
  }
}
