import 'package:auth_api/controller/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../config/router/app_route.dart';
import '../../utils/validator.dart';
import '../../data/models/register_user.dart';

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

  RegisterUser? registerUser;

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
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Image.asset("assets/images/app_logo.jpg"),
              const ListTile(
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
                        const SizedBox(
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
                    const SizedBox(
                      height: 40,
                    ),
                    // SizedBox(height: 10,),
                    Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Gender"),
                          const SizedBox(
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
                                          const EdgeInsets.fromLTRB(12, 5, 20, 5),
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Birthdate"),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: dateinput,
                            validator: (value) =>
                                Validator.validateDropDefaultData(
                                    value ?? ""),
                            decoration: InputDecoration(
                                // icon: Icon(Icons.calendar_today),
                                labelText: "Select Your Birth Date",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0))),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1910),
                                  lastDate: DateTime.now());

                              if (pickedDate != null) {
                                print(
                                    pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd')
                                        .format(pickedDate);
                                print(
                                    formattedDate);
                                setState(() {
                                  dateinput.text =
                                      formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Birthdate"),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: referralCode,
                            validator: (value) =>
                                Validator.validateText(value ?? ""),
                            decoration: InputDecoration(
                              labelText: "Referral Code",
                              hintText: "Enter Code",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.blueAccent)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            minWidth: 1000,
                            height: 60,
                            child: const Text(
                              'Next',
                              style: TextStyle(fontSize: 18),
                            ),
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textColor: Colors.white,
                            onPressed: () {
                              widget.user.birthdate = dateinput.text;
                              BlocProvider.of<AuthBloc>(context).add(
                                RegisterUserEvent(
                                  widget.user,
                                  () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.OTP,
                                      arguments: widget.user,
                                    );
                                  },
                                ),
                              );
                              // _register();
                            },
                          ),
                          const SizedBox(
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
