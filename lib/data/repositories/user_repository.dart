import 'package:dio/dio.dart';
import '../../core/services/api_endpoints.dart';
import '../../core/services/api_service.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  /// Fetch a paginated list of users
  Future<Response?> fetchUsers(String page) async {
    try {
      return await _apiService.get(ApiEndpoints.getUsers(page));
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Fetch user by ID
  Future<Response?> fetchUserById(String id) async {
    try {
      return await _apiService.get(ApiEndpoints.getUserById(id));
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Update user data
  Future<Response?> updateUser(String id, Map<String, dynamic> userData) async {
    try {
      return await _apiService.put(ApiEndpoints.updateUser(id), data: userData);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Delete a user
  Future<Response?> deleteUser(String id) async {
    try {
      return await _apiService.delete(ApiEndpoints.deleteUser(id));
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Handle API errors
  Response? _handleError(dynamic error) {
    if (error is DioException) {
      print('User API Error: ${error.response?.statusCode} - ${error.message}');
    } else {
      print('Unexpected Error: $error');
    }
    return null;
  }
}
