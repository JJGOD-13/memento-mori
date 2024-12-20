import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimePicker extends StatelessWidget {
  final TextEditingController ageController;
  final VoidCallback onSubmit;

  const TimePicker({
    super.key,
    required this.ageController,
    required this.onSubmit,
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
        ],
      ),
    );
  }
}
