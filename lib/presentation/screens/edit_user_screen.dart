import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_bloc.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_event.dart';
import 'package:unjdigital_flutask/blocs/user_details/user_details_state.dart';
import 'package:unjdigital_flutask/core/utils/validators.dart';
import 'package:unjdigital_flutask/data/models/user/user_model.dart';
import 'package:unjdigital_flutask/presentation/widgets/build_shimmer.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_snackbar.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_text_field.dart';
import 'package:unjdigital_flutask/presentation/widgets/form_shimmer.dart';

import '../widgets/custom_button.dart';

class EditUserScreen extends StatefulWidget {
  final int userId;

  const EditUserScreen({super.key, required this.userId});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  void _initializeForm(User user) {
    if (!_isInitialized) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit(User user) {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedUser = user.copyWith(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      context.read<UserDetailsBloc>().add(UpdateUserEvent(updatedUser));
      CustomSnackbar.show(context, "User has been updated");
      context.pop(); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          if (state is UserDetailsLoading) {
            return FormShimmer();
          } else if (state is UserDetailsLoaded) {
            final user = state.user;
            _initializeForm(user);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      labelText: 'Name',
                      validator:
                          Validators.validateName, // Using Validators class
                    ),
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          Validators.validateEmail, // Using Validators class
                    ),
                    CustomTextField(
                      controller: _phoneController,
                      labelText: 'Phone',
                      keyboardType: TextInputType.phone,
                      validator:
                          Validators.validatePhone, // Using Validators class
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      text: "Submit Changes",
                      onPressed: () => _submit(user),
                    )
                  ],
                ),
              ),
            );
          } else if (state is UserDetailsError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
