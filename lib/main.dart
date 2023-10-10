import 'package:auth_api/config/route_generator.dart';
import 'package:auth_api/presentation/screens/home.dart';
import 'package:auth_api/presentation/screens/otp.dart';
import 'package:auth_api/presentation/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/register_user.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone = prefs.getString("phone");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: RouteGenerator.generateRoute,
    home: phone == null ? SignIn() : Home(),
    builder: EasyLoading.init(),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: RouteGenerator.generateRoute,
//       home: phone == null ? SignIn() : Home(),
//       builder: EasyLoading.init(),
//     );
//   }
// }




