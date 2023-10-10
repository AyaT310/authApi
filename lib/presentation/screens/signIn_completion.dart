import 'package:auth_api/config/app_route.dart';
import 'package:auth_api/config/validator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user.dart';
import '../../data/repository/api_client.dart';

class SignInCompletion extends StatefulWidget {
  final String? phone;

  const SignInCompletion({
    this.phone,
  });

  @override
  State<SignInCompletion> createState() => _SignInCompletionState();
}

class _SignInCompletionState extends State<SignInCompletion> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = true;

  final ApiClient _apiClient = ApiClient();

  Future<void> _login() async {
    if (_key.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Processing Data'),
      //   backgroundColor: Colors.green.shade300,
      // ));
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000);
      Response res = await _apiClient.login(
        password: CheckUser(
          phone: widget.phone,
          password: passwordController.text.trim(),
        ),
      );

      // ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res.data['data']['access_token'] != null) {
        String accessToken = res.data['data']['access_token'];
        EasyLoading.show(status: 'Success...');
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.HOME, arguments: accessToken, (route) => false);
      } else {
        EasyLoading.show(status: 'Failed...');
        Navigator.pushReplacementNamed(context, AppRoutes.SIGNUP);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('Error'),
        //   backgroundColor: Colors.red.shade300,
        // ));
      }
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Image.asset("assets/images/app_logo.jpg"),
              ListTile(
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
                padding: EdgeInsets.symmetric(horizontal: 18),
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
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: 90,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Password can't be empty";
                            //   } else if (value.length < 8) {
                            //     return "Password can't be less than 8 characters";
                            //   }
                            // },
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
                              label: Text(
                                "Password",
                              ),
                              hintText: "Password",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            minWidth: 1000,
                            height: 60,
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: 18),
                            ),
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textColor: Colors.white,
                            onPressed: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString("phone", widget.phone!);
                              _login();
                            },
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
