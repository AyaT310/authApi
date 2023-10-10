import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../config/app_route.dart';
import '../../config/validator.dart';
import '../../data/models/register_user.dart';
import '../../data/repository/api_client.dart';

class SignUpCompletion extends StatefulWidget {
  final RegisterUser user;

  const SignUpCompletion({super.key, required this.user}); // Syntactic sugar

  @override
  State<SignUpCompletion> createState() => _SignUpCompletionState();
}

class _SignUpCompletionState extends State<SignUpCompletion> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController dateinput = TextEditingController();
  TextEditingController referralCode = TextEditingController();

  final ApiClient _apiClient = ApiClient();

  Future<void> _register() async {
    if (_key.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Processing Data'),
      //   backgroundColor: Colors.green.shade300,
      // ));
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000);
      RegisterUser? registerUser;

      registerUser = widget.user;

      registerUser.birthdate = dateinput.text;

      Response res = await _apiClient.registerUser(
        userData: registerUser,
      );

      print('@@@@ FSSS ${res.data}');

      // ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res.data['data']['access_token'] != null) {
        String accessToken = res.data['data']['access_token'];
        EasyLoading.show(status: 'Success...');
        Navigator.pushReplacementNamed(context, AppRoutes.OTP,arguments: RegisterUser());

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

  final _items = [
    'Male',
    'Female',
  ];
  String dropdownvalue = 'Male';

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
                title: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Please Enter The Required Data",
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
                      height: 40,
                    ),
                    // SizedBox(height: 10,),
                    Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gender"),
                          SizedBox(
                            height: 10,
                          ),
                          FormField<String>(
                              validator: (value) =>
                                  Validator.validateDropDefaultData(
                                      value ?? ""),
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 5, 20, 5),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownvalue,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded),
                                      iconSize: 24,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                      items: _items
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Birthdate"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: dateinput,
                            validator: (value) =>
                                Validator.validateDropDefaultData(value ?? ""),
                            decoration: InputDecoration(
                                // icon: Icon(Icons.calendar_today),
                                labelText: "Select Your Birth Date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1910),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now());

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateinput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Birthdate"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: referralCode,
                            validator: (value) =>
                                Validator.validateText(value ?? ""),
                            // validator: (value) {
                            //   if(value!.isEmpty){
                            //     return "Referral Code can't be empty";
                            //   }
                            // },
                            // onChanged: (value) {
                            //   _key.currentState!.validate();
                            // },
                            decoration: InputDecoration(
                              labelText: "Referral Code",
                              hintText: "Enter Code",
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
                            onPressed: () {
                              _register();
                              // _key.currentState?.validate();
                              // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.HOME, (route) => false);
                            },
                          ),
                          SizedBox(
                            height: 40,
                          )
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
