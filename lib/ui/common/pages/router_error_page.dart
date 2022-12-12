import 'package:flutter/material.dart';

class RouterErrorPage extends StatelessWidget {
  const RouterErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Requested screen doesn't exist."),
        ),
      ),
    );
  }
}
