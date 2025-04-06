// lib/bloc/user_event.dart

import 'package:equatable/equatable.dart';
import 'package:unjdigital_flutask/data/models/user/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {}

class AddUserEvent extends UserEvent {
  final User user;
  AddUserEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class SearchUsers extends UserEvent {
  final String query;
  SearchUsers(this.query);
  @override
  List<Object?> get props => [query];
}
