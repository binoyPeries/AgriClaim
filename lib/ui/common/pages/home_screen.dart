import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  const HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("HOME!!!$name"),
      ),
    );
  }
}
