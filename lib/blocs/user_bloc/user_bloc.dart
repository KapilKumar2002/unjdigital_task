import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user/user_model.dart';
import '../../data/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  bool _isFetching = false;
  int _currentPage = 1;
  bool _hasMore = true;
  late List<User> _allUsers;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<AddUserEvent>(_onAddUser);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (_isFetching || !_hasMore) return;
    _isFetching = true;

    try {
      if (_currentPage == 1) emit(Loading()); // show shimmer

      final cachedUsers = await _userRepository.fetchUsers(_currentPage);

      _hasMore = (cachedUsers.length / 10) <= _currentPage; // or use API flag
      if (_hasMore) _currentPage++;
      _allUsers = cachedUsers;

      emit(UsersLoaded(users: cachedUsers, hasMore: _hasMore));
    } catch (e) {
      emit(UserError("Failed to fetch users"));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(Loading());

      // Call repository to handle API + caching
      final users = await _userRepository.addUser(event.user);
      emit(
          UsersLoaded(users: users, hasMore: false)); // assuming hasMore = true
    } catch (e) {
      emit(UserError("Failed to add user: $e"));
    }
  }

  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(UsersLoaded(users: _allUsers, hasMore: true));
      return;
    }

    final filteredUsers = _allUsers.where((user) {
      final name = user.name.toLowerCase();
      final email = user.email.toLowerCase();
      return name.contains(query) || email.contains(query);
    }).toList();

    emit(UsersLoaded(users: filteredUsers, hasMore: true));
  }
}
