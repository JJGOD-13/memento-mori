import 'package:flutter/material.dart';

class MementoDrawer extends StatelessWidget {
  const MementoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Drawer(
        backgroundColor: Colors.black,
        child: const Center(
          child: Text(
            "Hello Achal",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
