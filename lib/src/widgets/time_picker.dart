import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memento_mori/src/utils/enums.dart';
import 'package:memento_mori/src/utils/time_to_live_algo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  var ageController = TextEditingController();

  void _saveDisplayPreferences(UserDisplayPreferences newValue) async {
    var prefs = SharedPreferencesAsync();
    prefs.setInt("userDisplayPreference", newValue.index);
  }

  void onPreferenceChanged(UserDisplayPreferences newValue) {
    _saveDisplayPreferences(newValue);
  }

  void submitInput() async {
    var prefs = SharedPreferencesAsync();
    var times = timeLeftToLive(int.tryParse(ageController.text), 80);
    prefs.setString("timesLeftToLive", jsonEncode(times?.toJson()));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memento Mori"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensure the column takes minimum space
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Your Age",
                errorStyle: const TextStyle(color: Colors.red),
                suffixIcon: IconButton(
                  onPressed: () {
                    ageController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: const OutlineInputBorder(),
              ),
              controller: ageController,
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your age";
                }
                if (int.tryParse(value) == null) {
                  return 'Your age should ideally be a number';
                } else {
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUnfocus,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: MaterialButton(
                padding: const EdgeInsets.all(10),
                onPressed: submitInput,
                color: Colors.blue,
                child: const Text("Submit"),
              ),
            ),
            DropdownButtonFormField(
              items: UserDisplayPreferences.values
                  // For each value in values convert it to a string and collect into a list.
                  .map<DropdownMenuItem<UserDisplayPreferences>>(
                      (UserDisplayPreferences value) {
                return DropdownMenuItem(
                    value: value,
                    child: Text(value.toString().split('.').last));
              }).toList(),
              onChanged: (UserDisplayPreferences? newValue) {
                if (newValue != null) {
                  onPreferenceChanged(newValue);
                }
              },
              value: UserDisplayPreferences.days,
            )
          ],
        ),
      ),
    );
  }
}
