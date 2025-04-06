import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_bloc.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_event.dart';
import 'package:unjdigital_flutask/di/locator.dart';
import 'package:unjdigital_flutask/presentation/screens/add_user_screen.dart';
import 'package:unjdigital_flutask/presentation/screens/edit_user_screen.dart';
import 'package:unjdigital_flutask/presentation/screens/error_screen.dart';
import 'package:unjdigital_flutask/presentation/screens/home_screen.dart';
import 'package:unjdigital_flutask/presentation/screens/splash_screen.dart';
import 'package:unjdigital_flutask/presentation/screens/user_details_screen.dart';
import 'routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.addUser,
        builder: (context, state) => const AddUserScreen(),
      ),
      GoRoute(
        path: AppRoutes.userDetails,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? -1;
          return BlocProvider.value(
            value: getIt<UserDetailsBloc>()..add(FetchUserById(id)),
            child: UserDetailsScreen(userId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.editUser,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return BlocProvider.value(
            value: getIt<UserDetailsBloc>()..add(FetchUserById(id)),
            child: EditUserScreen(userId: id),
          );
        },
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) {
          return ErrorScreen();
        },
      ),
    ],
  );
}
