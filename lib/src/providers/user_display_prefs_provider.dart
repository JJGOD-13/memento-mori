import 'package:flutter/material.dart';
import 'package:memento_mori/src/utils/enums.dart';

class UserDisplayPrefsProvider extends ChangeNotifier {
  UserDisplayPreferences userDisplayPreference;

  UserDisplayPrefsProvider({
    this.userDisplayPreference = UserDisplayPreferences.days,
  });

  void setUserDisplayPref({
    required UserDisplayPreferences newPref,
  }) async {
    userDisplayPreference = newPref;
    notifyListeners();
  }
}
