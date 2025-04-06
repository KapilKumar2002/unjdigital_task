import 'package:hive/hive.dart';
import 'package:unjdigital_flutask/core/services/user_service.dart';
import 'package:unjdigital_flutask/data/models/user/user_model.dart';

class UserRepository {
  final UserService _userService;
  final Box<User> _userBox = Hive.box<User>('users');
  final Box _cacheMetaBox = Hive.box('cache_meta');

  UserRepository(this._userService);

  /// Fetch paginated users
  Future<List<User>> fetchUsers(int page) async {
    final lastFetchedPage = _cacheMetaBox.get('last_page') as int? ?? 0;

    // If page already fetched and cache exists, return it
    if (page <= lastFetchedPage) {
      final cachedUsers = _getCachedUsers();
      return cachedUsers.reversed.toList();
    }

    try {
      final paginatedResponse = await _userService.fetchUsers(page);

      if (paginatedResponse.users.isNotEmpty) {
        _cacheUsers(paginatedResponse.users);
        _updateLastFetchedPage(page);
      }

      final allCachedUsers = _getCachedUsers();

      return allCachedUsers.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> addUser(User user) async {
    try {
      // API call (optional since you're mocking it)
      await _userService.addUser(user);

      // Save user to cache (Hive) with integer key
      final newId = _generateNewUserId(_userBox);
      final newUser = User(
        id: newId,
        name: user.name.trim(),
        email: user.email.trim(),
        phone: user.phone.trim(),
      );
      await _userBox.put(newId, newUser);

      final cachedUsers = _getCachedUsers();

      // Make sure newly added user comes on top

      return cachedUsers.reversed.toList();
    } catch (e) {
      throw Exception("Add user failed: $e");
    }
  }

  Future<User> getUserById(int id) async {
    User user;
    try {
      // Hit the API to simulate a freshness check (response is ignored)
      user = await _userService.fetchUserById(id);
    } catch (e) {
      rethrow;
    }

    final cachedUser = _userBox.get(id);
    if (cachedUser != null) {
      final updatedUser = cachedUser.merge(user);
      return updatedUser;
    } else {
      throw Exception("User with id $id not found in local cache.");
    }
  }

  Future<User?> updateUser(int id, User updatedUser) async {
    try {
      // Call API to update user
      await _userService.editUser(id, updatedUser);

      // Get the existing user from cache
      final cachedUser = _userBox.get(id);

      if (cachedUser != null) {
        // Merge updated fields with existing user
        final newUser = cachedUser.copyWith(
          name: updatedUser.name,
          email: updatedUser.email,
          phone: updatedUser.phone,
        );

        // Save the updated user in Hive
        await _userBox.put(id, newUser);
        return _userBox.get(id);
      } else {
        throw Exception("User not found in cache");
      }
    } catch (e) {
      rethrow;
    }
  }

  void _cacheUsers(List<User> users) {
    for (var user in users) {
      _userBox.put(user.id, user);
    }
  }

  List<User> _getCachedUsers() {
    return _userBox.values.toList()
      ..sort((a, b) => a.id.compareTo(b.id)); // consistent order
  }

  void _updateLastFetchedPage(int page) {
    _cacheMetaBox.put('last_page', page);
  }

  int _generateNewUserId(Box userBox) {
    final ids = userBox.keys.cast<int>().toList();
    if (ids.isEmpty) return 1; // Start from 1 if no users
    return ids.reduce((a, b) => a > b ? a : b) + 1;
  }
}
