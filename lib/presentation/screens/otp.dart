import 'package:auth_api/config/app_route.dart';
import 'package:auth_api/data/models/register_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/repository/api_client.dart';

class OTP extends StatefulWidget {
  final RegisterUser user;
  const OTP({super.key, required this.user});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController _pinController = TextEditingController();
  String currentText = "";

  final ApiClient _apiClient = ApiClient();

  Future<void> _checkotp() async {
    if (_key.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Processing Data'),
      //   backgroundColor: Colors.green.shade300,
      // ));
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000);
      // EasyLoading.show(status: 'Loading...');
      Response res = await _apiClient.otp(code: RegisterUser(
        code: _pinController.text
      ));

      print('@@@@ FSSS ${res.data}');

      if (_pinController.text == "1234") {
        EasyLoading.show(status: 'Success...');
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGNIN, (route) => false);

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
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
              children: [
              Image.asset("assets/images/app_logo.jpg"),
          ListTile(
            title: Text("Confirm Your Registration",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            subtitle: Text("Enter The Activation Code",style: TextStyle(fontSize: 16,)),
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
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            SizedBox(width: 6,),
            Container(
              width: 90,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)
              ),
            )
            ],
          ),
          SizedBox(height: 50,),
          Text("OTP", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey.shade500,),),
          SizedBox(height: 10,),
                Form(
                  key: _key,
                    child: Center(
                      child: PinCodeTextField(
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(20),
                          fieldHeight: 55,
                          fieldWidth: 70,
                          selectedColor: Colors.indigo,
                          inactiveColor: Colors.grey,
                          activeColor: Colors.grey
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        controller: _pinController,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      ),
                )
                ),
                Text("Activation Code Sent To Your Number", style: TextStyle(fontSize: 16,color: Colors.grey.shade700,),),
                SizedBox(height: 90,),
                MaterialButton(
                  minWidth: 1000,
                  height: 60,
                  child: Text('Next',style: TextStyle(fontSize: 18),),
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  textColor: Colors.white,
                  onPressed: () {
                    _checkotp();
                  },
                ),
              ]
          ),
    ),
              ]
          ),
        ),
      )
    );
  }
}

