import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memento_mori/main.dart';
import 'package:memento_mori/src/providers/user_age_provider.dart';
import 'package:memento_mori/src/providers/user_display_prefs_provider.dart';
import 'package:memento_mori/src/utils/enums.dart';
import 'package:memento_mori/src/widgets/memento_app_bar.dart';
import 'package:provider/provider.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MementoAppBar(
        renderSettings: false,
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
                onPressed: () {
                  var newAge = ageController.text;
                  context.read<UserAgeProvider>().setUserAge(
                      // This ideally should never fail since we validate user input
                      newAge: int.tryParse(newAge) ?? 0);
                  Navigator.popAndPushNamed(context, MementoRoutes.home);
                },
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
                  context
                      .read<UserDisplayPrefsProvider>()
                      .setUserDisplayPref(newPref: newValue);
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
