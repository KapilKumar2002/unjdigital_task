import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_details_event.dart';
import 'user_details_state.dart';
import '../../../data/repositories/user_repository.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserRepository _userRepository;

  UserDetailsBloc(this._userRepository) : super(UserDetailsInitial()) {
    on<FetchUserById>(_onFetchUserById);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onFetchUserById(
    FetchUserById event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(UserDetailsLoading());

    try {
      final user = await _userRepository.getUserById(event.userId);
      emit(UserDetailsLoaded(user));
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }

  Future<void> _onUpdateUser(event, emit) async {
    emit(UserDetailsLoading());
    try {
      final updatedUser = await _userRepository.updateUser(
          event.updatedUser.id, event.updatedUser);
      emit(UserDetailsLoaded(updatedUser!));
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }
}
