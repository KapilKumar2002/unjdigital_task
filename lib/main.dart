import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_bloc.dart';
import 'package:unjdigital_flutask/di/locator.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'data/models/user/company_model.dart';
import 'data/models/user/geo_location_model.dart';
import 'data/models/user/user_model.dart';
import 'data/repositories/user_repository.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); // Initialize Hive

  // Register Hive adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(GeoLocationAdapter());

  await Hive.openBox<User>('users'); // ✅ You did this
  await Hive.openBox('cache_meta');

  setupLocator(); // Initialize dependency injection (GetIt)

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UserBloc>()),
        BlocProvider(create: (_) => getIt<UserDetailsBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'User Management App',
        routerConfig: AppRouter.router,
      ),
    );
  }
}
