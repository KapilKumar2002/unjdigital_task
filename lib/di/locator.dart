import 'package:get_it/get_it.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_bloc.dart';
import 'package:unjdigital_flutask/core/services/user_service.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../core/services/api_service.dart';
import '../../data/repositories/user_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerLazySingleton<UserService>(
    () => UserService(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<UserService>()),
  );

  getIt.registerFactory<UserBloc>(
    () => UserBloc(getIt<UserRepository>()),
  );

  getIt.registerLazySingleton<UserDetailsBloc>(
    () => UserDetailsBloc(getIt<UserRepository>()),
  );
}
