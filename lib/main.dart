import 'package:auth_api/config/router/route_generator.dart';
import 'package:auth_api/controller/home_bloc/home_bloc.dart';
import 'package:auth_api/data/repository/api_home.dart';
import 'package:auth_api/presentation/screens/home.dart';
import 'package:auth_api/presentation/screens/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/auth_bloc/auth_bloc.dart';
import 'data/repository/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  var phone = prefs.getString("phone");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          ApiClient(),
        ),
      ),
      BlocProvider(
        create: (context) => HomeBloc(
          ApiHome(),
        ),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: phone == null ? const SignIn() : const Home(),
      builder: EasyLoading.init(),
    ),
  ));
}