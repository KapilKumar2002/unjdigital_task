import 'package:equatable/equatable.dart';

import '../../data/models/user/user_model.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchUserById extends UserDetailsEvent {
  final int userId;

  const FetchUserById(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateUserEvent extends UserDetailsEvent {
  final User updatedUser;
  const UpdateUserEvent(this.updatedUser);
  @override
  List<Object> get props => [updatedUser];
}
