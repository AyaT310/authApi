import 'package:auth_api/data/models/register_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../config/router/app_route.dart';
import '../../data/models/user.dart';
import '../../data/repository/api_client.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiClient _apiClient;
  String? accessToken;
  RegisterUser? user;

  // String? fullPhone;

  AuthBloc(
    this._apiClient, {
    this.user,
  }) : super(AuthInitial()) {
    on<CheckUserEvent>(_checkUserEvent);
    on<RegisterUserEvent>(_registerUserEvent);
    on<LoginEvent>(_loginEvent);
    on<OtpEvent>(_otpEvent);
  }

  Future<void> _checkUserEvent(
    CheckUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    EasyLoading.show();
    try {
      final response = await _apiClient.checkIfRegistered(phone: event.phone);
      if (response.statusCode == 200) {
        if (response.data['data']['is_exist'] == true) {
          event.existAction!();
        } else {
          event.notExistAction!();
        }
      }
    } catch (e) {
      if (e is DioException) {
        EasyLoading.showError('Invalid Credentials');
      }
    }

    EasyLoading.dismiss();
  }

  void _registerUserEvent(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    EasyLoading.show();

    try {
      final response = await _apiClient.registerUser(userData: event.userData);
      if (response.statusCode == 200) {
        event.action!();
      }
    } catch (e) {
      if (e is DioException) {
        emit(AuthFailure(e));
      }
    }
    EasyLoading.dismiss();
  }

  void _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    EasyLoading.show();

    try {
      final response = await _apiClient.login(password: event.password);
      if (response.statusCode == 200) {
        accessToken = response.data['data']['access_token'];
        event.action!();
      }
    } catch (e) {
      if (e is DioException) {
        emit(AuthFailure(e));
      }
    }
    EasyLoading.dismiss();
  }

  void _otpEvent(OtpEvent event, Emitter<AuthState> emit) async {
    EasyLoading.show();

    try {
      final response = await _apiClient.otp(code: event.code);
      if (response.statusCode == 200) {
        event.action!();
      }
    } catch (e) {
      if (e is DioException) {
        emit(AuthFailure(e));
      }
    }
    EasyLoading.dismiss();
  }
}
