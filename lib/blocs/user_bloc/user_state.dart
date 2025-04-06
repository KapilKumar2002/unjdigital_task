import 'package:equatable/equatable.dart';
import 'package:unjdigital_flutask/data/models/user/user_model.dart';

class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class Loading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  final bool hasMore;

  UsersLoaded({required this.users, required this.hasMore});

  @override
  List<Object?> get props => [users, hasMore];
}

class UserError extends UserState {
  final String message;
  UserError(this.message);

  @override
  List<Object?> get props => [message];
}
