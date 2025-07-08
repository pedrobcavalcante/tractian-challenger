import 'package:dio/dio.dart';
import 'api_client.dart';

class ApiClientImpl implements ApiClient {
  final Dio _dio;

  ApiClientImpl({BaseOptions? options, List<Interceptor>? interceptors})
    : _dio = Dio(
        options ?? BaseOptions(baseUrl: 'https://fake-api.tractian.com'),
      ) {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  @override
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get<T>(
      endpoint,
      queryParameters: queryParameters,
    );
    return response.data as T;
  }

  @override
  Future<T> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.post<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data as T;
  }

  @override
  Future<T> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.put<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data as T;
  }

  @override
  Future<T> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.delete<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data as T;
  }
}
