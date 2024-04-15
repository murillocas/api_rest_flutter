import 'package:flutter/material.dart';


class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Column(
        children: [
          Text("tem um  aki"),
          Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}