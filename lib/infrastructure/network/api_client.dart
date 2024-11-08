import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fake-api.tractian.com'));

  Future<dynamic> get(String endpoint) async {
    final response = await _dio.get(endpoint);
    return response.data;
  }
}
