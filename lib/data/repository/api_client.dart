import 'package:auth_api/utils/constatns.dart';
import 'package:auth_api/data/models/register_user.dart';
import 'package:auth_api/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiClient {
  final Dio _dio = Dio();

  Map<String, dynamic> headers = {
    'Accept': 'application/json',
  };
  Map<String, dynamic> accessheaders = {
    'Accept': 'application/json',
    "Token" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWI3OTEwODYxNjk5OTliNWJhNTFiMmViN2NjNmYxYzM0NTk5OTA5ZGNhY2I5MWMyMjdjZDA0OTYzZmZhMTE0ZTBjOTA2ZTRkYjZhY2IxMDAiLCJpYXQiOjE2OTcwMTA5MTEsIm5iZiI6MTY5NzAxMDkxMSwiZXhwIjoxNzI4NjMzMzExLCJzdWIiOiI5NzBjMWY0OS05MDQyLTRiYmYtYWQyZC00ZTlmOWEyZDNiNzUiLCJzY29wZXMiOltdfQ.ht_NY7SAxMRWditCY-JR1DhlWWnHpkkTA6blRc4oNT6zNxK9QBXShoCzTwIOJE0kGxecYjlXsa_n7ZQqYcpREFT0laPAiOVd5Zswk6MhYud9glbOAFNgBYt0mvelBJGPGKqSfJShhH2lnraDPl8qsZ_-RILBm_4rVaNZ1O9b-doL13WC8SPcs8hKmw_in2JdIcsW4iyg2gjljr9Xhi8RgitL3CITzXNGb5hh-wMniwf_s_vQO3xjgFf7C5z3eUNIjCmyLDfra1AYZnTeHj9xldS25ZdIUGKp_h1I886_OI-XxNrNBKaFnaRltef4COINhyzBv-3q_D5AI9BBldKTsa3Kyj_ZkKq0xxd89OSOed8tA0M5BiB9P_dsFpVfFAfGI3sXvI99ABDG6ByWV1UYT2RVcjHr7DdgOX8-k7tftZ6EHCSewGdNwH13RoN9ITLlayHlFTKIkU1sOjU9Y"
  };

  Future<Response> checkIfRegistered({required CheckUser phone}) async {
    print('Body CheckUser: ${phone.toJson()}');
    try {
      Response response = await _dio.post(
        baseUrl + "check-user",
        data: phone.toJson(),
        options: Options(
          headers: headers,
        ),
      );
      return response;
    } on DioException catch (e) {
      print('ERORR => ${e.error}');
      return e.response!;
    }
  }

  Future<Response> registerUser({required RegisterUser userData}) async {
    print('Body Register: ${userData.toJson()}');
    try {
      Response response = await _dio.post(baseUrl + "register",
        data: userData.toJson(),
        options: Options(
          headers: headers,
        ),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> login({required CheckUser password}) async {
    print('Body Login: ${password.toJson()}');
    try {
      Response response = await _dio.post(baseUrl + "login",
          data: password.toJson(),
          options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> otp({required RegisterUser code, required }) async {
    print('Body OTP: ${code.toJson()}');
    try {
      Response response = await _dio.post(baseUrl + "activate",
        data: code.toJson(),
        options: Options(headers: accessheaders),
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print(e.response);
      EasyLoading.showError("something went wrong");
      return e.response!;
    }
  }
}
