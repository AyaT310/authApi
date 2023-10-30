import 'package:auth_api/config/router/route_generator.dart';
import 'package:auth_api/data/repository/api_home.dart';
import 'package:auth_api/data/repository/api_retailers.dart';
import 'package:auth_api/l10n/l10n.dart';
import 'package:auth_api/presentation/screens/home.dart';
import 'package:auth_api/presentation/screens/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'buisnessLogic/auth_bloc/auth_bloc.dart';
import 'buisnessLogic/home_bloc/home_bloc.dart';
import 'buisnessLogic/retailers_bloc/retailer_bloc.dart';
import 'data/repository/api_client.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  var phone = prefs.getString("phone");
  var language = prefs.getBool("isEnglish");
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
      BlocProvider(
        create: (context) => RetailerBloc(
          ApiRetailers(),
        ),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: phone == null ? const SignIn() : const Home(),
      builder: EasyLoading.init(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: L10n.all,
      locale: language! ? Locale("en") : Locale("ar"),
      // Locale(isEnglish! ? "en" : "ar") ,
    ),
  ));
}