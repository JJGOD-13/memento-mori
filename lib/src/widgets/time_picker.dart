import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memento_mori/src/utils/enums.dart';

class TimePicker extends StatelessWidget {
  final TextEditingController ageController;
  final VoidCallback onSubmit;
  final Function(UserDisplayPreferences) onPreferenceChanged;

  const TimePicker({
    super.key,
    required this.ageController,
    required this.onSubmit,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
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
              onPressed: onSubmit,
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
                  value: value, child: Text(value.toString().split('.').last));
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
    );
  }
}
