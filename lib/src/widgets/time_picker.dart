import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final TextEditingController ageController;
  final VoidCallback onSubmit;

  const TimePicker(
      {super.key, required this.ageController, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Enter Your Age",
                suffixIcon: IconButton(
                    onPressed: () {
                      ageController.clear();
                    },
                    icon: const Icon(Icons.clear)),
                border: const OutlineInputBorder()),
            controller: ageController,
            keyboardType: const TextInputType.numberWithOptions(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: MaterialButton(
              padding: const EdgeInsets.all(10),
              onPressed: onSubmit,
              color: Colors.blue,
              child: const Text("Set Age"),
            ),
          ),
        ],
      ),
    );
  }
}
