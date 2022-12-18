import 'package:flutter/material.dart';

class OfficerHomePage extends StatefulWidget {
  const OfficerHomePage({Key? key}) : super(key: key);

  @override
  State<OfficerHomePage> createState() => _OfficerHomePageState();
}

class _OfficerHomePageState extends State<OfficerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Officer"),
    );
  }
}
