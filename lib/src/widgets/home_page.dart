import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final int timeLeftToLive;
  const HomePage({super.key, required this.timeLeftToLive});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatter = NumberFormat('#,###');
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(90.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center items vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center items horizontally
            children: [
              const Text(
                "You have",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              // Users time left to live.
              Text(
                widget.timeLeftToLive == 0
                    ? "∞"
                    : formatter.format(widget.timeLeftToLive),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                textAlign: TextAlign.center,
                "Days left to live",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              // Textfield to take user input.
            ],
          ),
        ),
      ),
    );
  }
}
