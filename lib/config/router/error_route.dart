import 'package:flutter/material.dart';

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Page Not Found"),
      ),
    );
  }
}