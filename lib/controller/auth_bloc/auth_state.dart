part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Response response;
  AuthSuccess(this.response);
}

class AuthSignupSuccess extends AuthState {
  final Response response;
  AuthSignupSuccess(this.response);
}

class AuthFailure extends AuthState {
  final DioException error;
  AuthFailure(this.error);
}