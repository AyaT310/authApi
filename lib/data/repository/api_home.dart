import 'package:auth_api/data/models/home_model.dart';
import 'package:auth_api/utils/constatns.dart';
import 'package:dio/dio.dart';

class ApiHome {
  final dio = Dio();

  Future<HomeData> fetchData() async {
    try {
      Response response = await dio.get("${homeBaseUrl}home");
      if (response.statusCode == 200) {
        final data = response.data;
        return HomeData.fromJson(data);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}