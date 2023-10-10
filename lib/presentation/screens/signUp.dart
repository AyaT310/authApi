import 'package:auth_api/config/app_route.dart';
import 'package:flutter/material.dart';
import '../../config/validator.dart';
import '../../data/models/register_user.dart';

class SignUp extends StatefulWidget {
  final String? phone;

  const SignUp({super.key, this.phone});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = true;

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
                      height: 40,
                    ),
                    // SizedBox(height: 10,),
                    Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                "(Real Name)",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: firstNameController,
                                  validator: (value) =>
                                      Validator.validateName(value ?? ""),
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    hintText: "First Name",
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  validator: (value) =>
                                      Validator.validateName(value ?? ""),
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    hintText: "Last Name",
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Email"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) =>
                                Validator.validateEmail(value ?? ""),
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Email",
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
                            height: 10,
                          ),
                          Text("Password"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: _showPassword,
                            controller: passwordController,
                            validator: (value) =>
                                Validator.validatePassword(value ?? ""),
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
                            onPressed: () {
                              _key.currentState?.validate();
                              Navigator.pushNamed(
                                context,
                                AppRoutes.SIGNUPCOMPLETION,
                                arguments: RegisterUser(
                                  phone: widget.phone,
                                  firstName: lastNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
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
