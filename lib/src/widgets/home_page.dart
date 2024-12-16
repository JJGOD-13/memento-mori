import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String timeLeftToLive;
  const HomePage({super.key, required this.timeLeftToLive});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                widget.timeLeftToLive == '' ? "∞" : widget.timeLeftToLive,
                style: const TextStyle(color: Colors.white, fontSize: 90),
              ),
              const Text(
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
