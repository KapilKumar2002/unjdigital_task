import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_event.dart';
import 'package:unjdigital_flutask/presentation/widgets/build_profile_shimmer.dart';
import 'package:unjdigital_flutask/presentation/widgets/build_shimmer.dart';
import 'package:unjdigital_flutask/presentation/widgets/build_user_details.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_button.dart';
import '../../blocs/user_details/user_details_bloc.dart';
import '../../blocs/user_details/user_details_state.dart';
import '../../data/models/user/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userId;

  const UserDetailsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          if (state is UserDetailsLoading) {
            return BuildProfileShimmer();
          } else if (state is UserDetailsLoaded) {
            return BuildUserDetails(user: state.user);
          } else if (state is UserDetailsError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.push(
                '/error', // Navigate to the error screen
                extra: {
                  'errorMessage': state.message, // Pass the error message
                  'onRetry': () =>
                      context.read<UserDetailsBloc>().add(FetchUserById(userId))
                },
              );
            });
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
