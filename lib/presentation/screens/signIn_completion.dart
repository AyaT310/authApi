import 'package:auth_api/config/router/app_route.dart';
import 'package:auth_api/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/auth_bloc/auth_bloc.dart';
import '../../data/models/user.dart';

class SignInCompletion extends StatefulWidget {
  final String? phone;

  const SignInCompletion({super.key,
    this.phone,
  });

  @override
  State<SignInCompletion> createState() => _SignInCompletionState();
}

class _SignInCompletionState extends State<SignInCompletion> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Image.asset("assets/images/app_logo.jpg"),
              const ListTile(
                title: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Please Enter Your Password",
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 90,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 90,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            obscureText: _showPassword,
                            controller: passwordController,
                            validator: (value) =>
                                Validator.validatePassword(value ?? ""),
                            onChanged: (value) {
                              _key.currentState!.validate();
                            },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(
                                      () => _showPassword = !_showPassword);
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              label: const Text(
                                "Password",
                              ),
                              hintText: "Password",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.blueAccent)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          MaterialButton(
                            minWidth: 1000,
                            height: 60,
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textColor: Colors.white,
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("phone", widget.phone!);
                              BlocProvider.of<AuthBloc>(context).add(
                                LoginEvent(
                                  CheckUser(
                                    phone: widget.phone,
                                    password: passwordController.text.trim(),
                                  ),
                                  () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.HOME,
                                      arguments:
                                          BlocProvider.of<AuthBloc>(context)
                                              .accessToken,
                                      (route) => false,
                                    );
                                  },
                                ),
                              );
                              // _login();
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
