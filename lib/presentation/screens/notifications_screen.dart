import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final message;
  const NotificationsScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${message?.notification?.title}"),
            Text("${message?.notification?.body}"),
            Text("${message?.data}"),
          ],
        ),
      ),
    );
  }
}
