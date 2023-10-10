import 'package:auth_api/config/app_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key, Object? accesstoken});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
          color: Colors.indigo,
          textColor: Colors.white,
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('phone');
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGNIN, (route) => false);
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
