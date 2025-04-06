// lib/data/services/user_service.dart

import 'package:dio/dio.dart';
import 'package:unjdigital_flutask/data/models/user/paginated_user_model.dart';
import 'package:unjdigital_flutask/data/models/user/user_model.dart';
import '../services/api_service.dart';
import 'api_endpoints.dart';

class UserService {
  final ApiService _apiService;

  UserService(this._apiService);

  Future<PaginatedUserModel> fetchUsers(int page) async {
    try {
      final response = await _apiService.get(ApiEndpoints.getUsers(page));
      if (response != null && response.statusCode == 200) {
        return PaginatedUserModel.fromJson(response.data);
      }
      throw Exception("Failed to load users");
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }

  Future<User> fetchUserById(int id) async {
    try {
      final response = await _apiService.get(ApiEndpoints.getUserById(id));
      if (response != null && response.statusCode == 200) {
        return User.fromJson(response.data);
      }
      throw Exception("Failed to load user details");
    } catch (e) {
      throw Exception("Error fetching user details: $e");
    }
  }

  Future<User> addUser(User user) async {
    try {
      final response =
          await _apiService.post(ApiEndpoints.addUser, data: user.toJson());

      if (response == null || response.statusCode != 201) {
        throw Exception("Failed to add user");
      } else {
        return User.fromJson(response.data);
      }
    } catch (e) {
      throw Exception("API error while adding user: $e");
    }
  }

  Future<void> editUser(int id, User user) async {
    try {
      final response = await _apiService.put(ApiEndpoints.updateUser(id),
          data: user.toJson());
      if (response == null || response.statusCode != 200) {
        throw Exception("Failed to update user");
      }
    } catch (e) {
      throw Exception("Error updating user: $e");
    }
  }
}
