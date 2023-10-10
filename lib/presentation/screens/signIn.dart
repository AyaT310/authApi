import 'package:auth_api/config/app_route.dart';
import 'package:auth_api/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../data/repository/api_client.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController phoneController = TextEditingController();

  final ApiClient _apiClient = ApiClient();

  String? countryCode;

  Future<void> _checkRegistration() async {
    if (_key.currentState!.validate()) {
      String fullPhone =
          '${countryCode ?? '20'}-${phoneController.text.trim()}';
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Processing Data'),
      //   backgroundColor: Colors.green.shade300,
      // ));
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000);
      Response res = await _apiClient.checkIfRegistered(
        phone: CheckUser(
          phone: fullPhone,
        ),
      );

      print('@@@@ FSSS ${res.data}');

      // ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res.data['data']['is_exist'] == true) {
        EasyLoading.show(status: 'Loading...');
        Navigator.pushNamed(
          context,
          AppRoutes.SIGNINPASS,
          arguments: fullPhone,
        );
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.SIGNUP,arguments: fullPhone);

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
                subtitle: Text("Please Enter Your Mobile Number",
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
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: 90,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Mobile Number",
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
                          IntlPhoneField(
                            initialCountryCode: "EG",
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^0+'), //users can't type 0 at 1st position
                              ),
                            ],
                            controller: phoneController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Phone Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            showCountryFlag: false,
                            languageCode: "en",
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              countryCode = country.fullCountryCode;
                              print("country changed to: " +
                                  country.name +
                                  ' ${country.fullCountryCode}');
                            },
                          ),
                          SizedBox(height: 25),
                          Text("By login to account, you agree our"),
                          TextButton(
                              onPressed: () {},
                              child: Text("Terms and conditions")),
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
                            onPressed: () {
                              _checkRegistration();
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
