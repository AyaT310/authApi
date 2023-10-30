import 'package:auth_api/data/models/register_user.dart';
import 'package:auth_api/presentation/screens/all_retailers.dart';
import 'package:auth_api/presentation/screens/home.dart';
import 'package:auth_api/presentation/screens/otp.dart';
import 'package:flutter/material.dart';
import '../../presentation/screens/signIn.dart';
import '../../presentation/screens/signIn_completion.dart';
import '../../presentation/screens/signUp.dart';
import '../../presentation/screens/signup_completion.dart';
import 'app_route.dart';
import 'error_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.SIGNIN:
        return MaterialPageRoute(
          builder: (context) => const SignIn(),
        );

      case AppRoutes.SIGNINPASS:
        return MaterialPageRoute(
          builder: (context) => SignInCompletion(
            phone: args != null ? args as String : '',
          ),
        );

      case AppRoutes.SIGNUP:
        return MaterialPageRoute(
          builder: (context) => SignUp(phone: args != null ? args as String : ''),
        );

      case AppRoutes.SIGNUPCOMPLETION:
        return MaterialPageRoute(
          builder: (context) => SignUpCompletion(user :args as RegisterUser),
        );

      case AppRoutes.OTP:
        return MaterialPageRoute(
          builder: (context) => OTP(user :args as RegisterUser),
        );

      case AppRoutes.HOME:
        return MaterialPageRoute(
          builder: (context) => Home(accesstoken: args),
        );

      case AppRoutes.ALLRETAILERS:
        return MaterialPageRoute(
          builder: (context) =>  const AllRetailersScreen(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const ErrorRoute());
    }
  }
}
