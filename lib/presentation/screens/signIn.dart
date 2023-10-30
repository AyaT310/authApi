import 'package:auth_api/config/router/app_route.dart';
import 'package:auth_api/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../buisnessLogic/auth_bloc/auth_bloc.dart';
import '../../services/auth_integration_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController phoneController = TextEditingController();

  String? countryCode;
  String? fullPhone;

  @override
  void initState() {
    super.initState();
    updatePhoneNumber();
  }

  updatePhoneNumber() {
    fullPhone = '${countryCode ?? '20'}-${phoneController.text.trim()}';
  }

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
               ListTile(
                title: Text(
                  AppLocalizations.of(context)!.signIn,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(AppLocalizations.of(context)!.enterMobNum,
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
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
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
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      AppLocalizations.of(context)!.mobNum,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(
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
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                    r'^0+'), //users can't type 0 at 1st position
                              ),
                            ],
                            controller: phoneController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.blueAccent)),
                              labelText: AppLocalizations.of(context)!.mobNum,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            showCountryFlag: false,
                            languageCode: "en",
                            onChanged: (phone) {
                              updatePhoneNumber();
                              print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              countryCode = country.fullCountryCode;
                              print("country changed to: " +
                                  country.name +
                                  ' ${country.fullCountryCode}');
                            },
                          ),
                          const SizedBox(height: 25),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.agreeLogIn),
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(AppLocalizations.of(context)!.termsAndCondition,overflow: TextOverflow.clip,)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            minWidth: 1000,
                            height: 60,
                            child: Text(
                              AppLocalizations.of(context)!.next,
                              style: TextStyle(fontSize: 18),
                            ),
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textColor: Colors.white,
                            onPressed: () {
                              if(_key.currentState!.validate()){
                                BlocProvider.of<AuthBloc>(context).add(
                                  CheckUserEvent(
                                    phone: CheckUser(
                                      phone: fullPhone,
                                    ),
                                    existAction: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.SIGNINPASS,
                                        arguments: fullPhone,
                                      );
                                    },
                                    notExistAction: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.SIGNUP,
                                        arguments: fullPhone,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 80),
                                width: 200,
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/google_logo.png"),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.signWithGoogle,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                // signInWithGoogle();
                                AuthIntegrationServices()
                                    .signInWithGoogle(context);
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          // InkWell(
                          //     child: Container(
                          //       margin: EdgeInsets.symmetric(horizontal: 80),
                          //       width: 200,
                          //       height: 50,
                          //       padding: EdgeInsets.symmetric(horizontal: 2),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(20),
                          //         color: Colors.grey.shade100,
                          //       ),
                          //       child: Center(
                          //         child: Row(
                          //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             Container(
                          //               width: 30,
                          //               height: 30,
                          //               decoration: BoxDecoration(
                          //                 image: DecorationImage(
                          //                     image: AssetImage(
                          //                         "assets/images/facebook_logo.png"),
                          //                     fit: BoxFit.cover),
                          //                 shape: BoxShape.circle,
                          //               ),
                          //             ),
                          //             Text(
                          //               "Sign In With Facebook",
                          //               style: TextStyle(
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     onTap: () async {
                          //       // signInWithFacebook();
                          //       AuthIntegrationServices()
                          //           .signInWithFacebook(context);
                          //     }),
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
