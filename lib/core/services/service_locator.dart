import 'package:get_it/get_it.dart';
import 'api_service.dart';
import '../../data/repositories/user_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepository(getIt<ApiService>()));
}
