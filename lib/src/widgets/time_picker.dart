import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  final _formKey = GlobalKey<FormBuilderState>();
  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Variables

    var usrAge = context.watch<UserAgeProvider>().userAge;
    ageController.text = usrAge.toString();
    var usrDeathDay = context.watch<UserAgeProvider>().genericDeathDay;

    var usrDispPref =
        context.watch<UserDisplayPrefsProvider>().userDisplayPreference;

    return Scaffold(
      appBar: MementoAppBar(
        renderSettings: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensure the column takes minimum space
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FormBuilderTextField(
                name: 'age',
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
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.positiveNumber(),
                  FormBuilderValidators.max(usrDeathDay, inclusive: false),
                ]),
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FormBuilderDropdown(
                  name: 'displayPref',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: UserDisplayPreferences.values
                      // For each value in values convert it to a string and collect into a list.
                      .map<DropdownMenuItem<UserDisplayPreferences>>(
                    (UserDisplayPreferences value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          Casing.titleCase(
                            value.toString().split('.').last,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (UserDisplayPreferences? newValue) {
                    if (newValue != null) {
                      context
                          .read<UserDisplayPrefsProvider>()
                          .setUserDisplayPref(newPref: newValue);
                    }
                  },
                  initialValue: usrDispPref,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: MaterialButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var newAge = ageController.text;
                      context.read<UserAgeProvider>().setUserAge(
                            newAge: int.parse(newAge),
                          );
                      Navigator.popAndPushNamed(context, MementoRoutes.home);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black26,
                          content: Text(
                            "Please correct any mistakes in the form",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                  color: Colors.blue,
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
