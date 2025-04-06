import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unjdigital_flutask/blocs/user_bloc/user_bloc.dart';
import 'package:unjdigital_flutask/blocs/user_bloc/user_event.dart';
import 'package:unjdigital_flutask/core/utils/validators.dart';
import 'package:unjdigital_flutask/data/models/user/user_model.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_button.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_snackbar.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_text_field.dart';
// Ensure to import the validators class

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _isSubmitting = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch, // Use String ID
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    context.read<UserBloc>().add(AddUserEvent(newUser));

    setState(() => _isSubmitting = false);
    CustomSnackbar.show(context, "User has been created");
    context.pop(true); // Navigate back to home with success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isSubmitting
              ? const Center(child: CircularProgressIndicator())
              : Form(
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
                      _isSubmitting
                          ? CircularProgressIndicator(
                              color: Colors.blueAccent,
                            )
                          : CustomElevatedButton(
                              text: "Add User", onPressed: _submit)
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
