import 'package:equatable/equatable.dart';
import '../../../data/models/user/user_model.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object?> get props => [];
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final User user;

  const UserDetailsLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserDetailsError extends UserDetailsState {
  final String message;

  const UserDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
