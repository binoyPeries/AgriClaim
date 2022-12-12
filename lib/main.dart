import 'package:flutter/material.dart';

void main() {
  runApp(const AgriClaim());
}

class AgriClaim extends StatelessWidget {
  const AgriClaim({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(child: Text("setup")),
      ),
    );
  }
}
