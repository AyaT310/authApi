import 'package:auth_api/config/router/app_route.dart';
import 'package:auth_api/data/models/register_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../buisnessLogic/auth_bloc/auth_bloc.dart';
import '../../data/repository/api_client.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthBloc(
    ApiClient(),
  ),
  child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
              children: [
              Image.asset("assets/images/app_logo.jpg"),
           ListTile(
            title: Text(AppLocalizations.of(context)!.confirmRegistration,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            subtitle: Text(AppLocalizations.of(context)!.enterActivationCode,style: TextStyle(fontSize: 16,)),
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
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            const SizedBox(width: 6,),
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
          const SizedBox(height: 50,),
          Text(AppLocalizations.of(context)!.otp, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey.shade500,),),
          const SizedBox(height: 10,),
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
                Text(AppLocalizations.of(context)!.activationCodeSent, style: TextStyle(fontSize: 16,color: Colors.grey.shade700,),),
                const SizedBox(height: 90,),
                MaterialButton(
                  minWidth: 1000,
                  height: 60,
                  child: Text(AppLocalizations.of(context)!.next,style: TextStyle(fontSize: 18),),
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  textColor: Colors.white,
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      OtpEvent(
                        RegisterUser(
                          code: _pinController.text
                        ),
                            () {
                              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGNIN, (route) => false);
                        },
                      ),
                    );
                  },
                ),
              ]
          ),
    ),
              ]
          ),
        ),
      )
    ),
);
  }
}

