import 'package:flutter/material.dart';

class UserAgeProvider extends ChangeNotifier {
  int userAge;

  UserAgeProvider({
    this.userAge = 0,
  });

  void setUserAge({
    required int newAge,
  }) async {
    userAge = newAge;
    notifyListeners();
  }
}
