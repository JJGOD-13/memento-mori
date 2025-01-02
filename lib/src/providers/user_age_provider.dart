import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAgeProvider extends ChangeNotifier {
  int userAge;

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
  Future<void> setUserAge({required int newAge}) async{
    userAge = newAge;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userAge', newAge);
    notifyListeners();
  }
}
