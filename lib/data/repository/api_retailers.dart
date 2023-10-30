import 'package:auth_api/data/models/home_model.dart';
import 'package:auth_api/utils/constatns.dart';
import 'package:dio/dio.dart';

import '../models/all_retailers_model.dart';
import '../models/all_retailers_model.dart';

class ApiRetailers {
  final dio = Dio();

  Future<AllRetailers> fetchData(int? page) async {
    try {
      print("page number $page");
      Response response = await dio.get("${retailerBaseUrl}retailer?page=$page");
      if (response.statusCode == 200) {
        final data = response.data;
        return AllRetailers.fromJson(data);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}