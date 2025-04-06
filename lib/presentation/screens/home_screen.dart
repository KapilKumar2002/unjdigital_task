import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unjdigital_flutask/presentation/widgets/build_shimmer.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_floating_button.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_user_tile.dart';
import 'package:unjdigital_flutask/presentation/widgets/search_box.dart';
import 'package:unjdigital_flutask/routes/routes.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_event.dart';
import '../../blocs/user_bloc/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreUsers();
      }
    });
  }

  void _loadMoreUsers() {
    final state = context.read<UserBloc>().state;
    if (state is UsersLoaded && state.hasMore) {
      context.read<UserBloc>().add(FetchUsers());
    }
  }

  void _onSearchChanged(String query) {
    context.read<UserBloc>().add(SearchUsers(query));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("FlutTask"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Row(
            children: [
              Expanded(
                child: SearchBox(
                  searchController: _searchController,
                  onSearchChanged: _onSearchChanged,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => context.push(AppRoutes.addUser),
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is Loading && (state is! UsersLoaded)) {
            return const BuildShimmer();
          } else if (state is UsersLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text("No users found"));
            }

            return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(FetchUsers());
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.users.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < state.users.length) {
                      final user = state.users[index];
                      return CustomUserTile(
                        name: user.name,
                        email: user.email,
                        userId: user.id.toString(),
                        onTap: () => context.push(
                            '/user/${user.id}'), // Navigate to user details
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ));
          } else if (state is UserError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.push(
                '/error', // Navigate to the error screen
                extra: {
                  'errorMessage': state.message, // Pass the error message
                  'onRetry': () {
                    // Retry logic when retry button is pressed
                    context
                        .read<UserBloc>()
                        .add(FetchUsers()); // Or your retry logic
                  }
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
