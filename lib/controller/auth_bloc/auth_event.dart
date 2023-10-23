part of 'auth_bloc.dart';

abstract class AuthEvent {}

class CheckUserEvent extends AuthEvent {
  final CheckUser phone;
  final Function()? existAction;
  final Function()? notExistAction;

  CheckUserEvent({
    required this.phone,
    required this.existAction,
    required this.notExistAction,
  });
}

class RegisterUserEvent extends AuthEvent {
  final RegisterUser userData;
  final Function()? action;

  RegisterUserEvent(this.userData, this.action);
}

class LoginEvent extends AuthEvent {
  final CheckUser password;
  final Function()? action;

  LoginEvent(this.password, this.action);
}

class OtpEvent extends AuthEvent {
  final RegisterUser code;
  final Function()? action;

  OtpEvent(this.code, this.action);
}

class AuthLoadingEvent extends AuthEvent {}
