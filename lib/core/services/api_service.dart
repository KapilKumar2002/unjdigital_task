import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late final Dio _dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://your-api-url.com/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: \${options.method} \${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: \${response.statusCode} \${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('Error: \${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<Response?> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response?> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response?> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response?> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } catch (e) {
      return _handleError(e);
    }
  }

  Response? _handleError(dynamic error) {
    if (error is DioException) {
      print('API Error: \${error.response?.statusCode} - \${error.message}');
    } else {
      print('Unexpected Error: \$error');
    }
    return null;
  }
}
