import 'package:auth_api/config/constatns.dart';
import 'package:auth_api/data/models/register_user.dart';
import 'package:auth_api/data/models/user.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Map<String, dynamic> headers = {
    'Accept': 'application/json',
  };
  Map<String, dynamic> accessheaders = {
    'Accept': 'application/json',
    "Token" : "eyJ0eXAi1iJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2M1MGYwN2EwNjFlMTUzY2RmOTNhNGI5NTlkZDUzOWVkZjc2YjkxNTQ5Mjg0Zjc1OTIyODY1M2U1MWNkOWI1NzhhNjBjN2RkNjMxZTAxYWIiLCJpYXQiOjE2OTY3NTY2MzcsIm5iZiI6MTY5Njc1NjYzNywiZXhwIjoxNzI4Mzc5MDM3LCJzdWIiOiI5ODk2ZTJhYy1hMTcwLTQxZWYtYjYzYS1hODUxMTA4ODM3ZjYiLCJzY29wZXMiOltdfQ.0Z9zECDKr0JfrXAl9z_QKumAIFsROI1Y93wYGqB9U09B0Ee1dVmSa3lIvA0bUVLZEmqrHbdVnhbT6dzuJG1s0OVyCVXKLTK3Z6VkPP2KJJ25WH7DuLb4vXSRBXw7lMHlU_uIOW0NsnrUP5_-miG8hkfQmYaqI-ls56Nvha3jWu7TU-yOVojh10HQ-kmIRVUvdkusMikNlXtzHBQ2tgUrNUXQAJxtXK06rLNoeLweUbfKuO22Yc5bNZUZv7vXxw8zRufTHLeJXbUepZjoqvucEUkk3vcluXzNHh1aTMHwMOHM3ClEqgrcAjZ-eKUP6MoayH0EFvIsaiG7-OpnKcO_2mtlbpPaZ93pmj14tqFqahOxSPc3O1KWru-AMvHQcDGbdn_2JxagEN1BoooLKP68bqW9cPbb2i8fiikGB9E2dkpwxpORQXBgQViHsW1FripDss0wc9LhK4IGtMsjp3rMSd_6UE4sBz_Pa8xis4eb7X4APCP0aKNfOMNnSdwBPKl0eYNxd68C0-8TmBWtS3lOWOo-jSFAPrDX1-6cbCuoAaL6kjyglaoXihCinc3Ikm5O25gO4cX830jPUbFfbRpgw0DnXPuQaVyCidK0l8aVLwXLGatbSyWFBMufqKb7Yv_jXRnV1nQtscmWkFoN9jFOxP7zMrIVYtnM9vT0bKsyc94"
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

  Future<Response> otp({required RegisterUser code}) async {
    print('Body OTP: ${code.toJson()}');
    try {
      Response response = await _dio.post(baseUrl + "activate",
        data: code.toJson(),
        options: Options(headers: accessheaders),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
