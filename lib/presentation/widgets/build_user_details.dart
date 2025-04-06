import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unjdigital_flutask/data/models/user/user_model.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_button.dart';

class BuildUserDetails extends StatelessWidget {
  final User user;
  const BuildUserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Profile Image with a hover effect
        Center(
          child: GestureDetector(
            onTap: () {
              // Add functionality for tapping profile picture, maybe show full-screen or edit
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile picture tapped!')),
              );
            },
            child: CircleAvatar(
              radius: 50, // Size of the avatar
              backgroundColor:
                  Colors.blueAccent, // Background color of the avatar
              child: Icon(
                Icons.person, // User icon
                size: 60, // Size of the icon
                color: Colors.white, // Icon color
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // User Name
        Text("Name: ${user.name}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )),
        const SizedBox(height: 8),

        // Email with stylish color
        Text("Email: ${user.email}",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 8),

        // Phone number with subtle text color
        Text("Phone: ${user.phone}",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            )),
        const SizedBox(height: 8),

        // Address (optional)
        if (user.address != null)
          Text("Address: ${user.address}",
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
        const SizedBox(height: 16),

        // Stylish Animated Button (Edit Profile)
        CustomElevatedButton(
          onPressed: () {
            // Handle the edit action here
            context.push(
              '/edit-user/${user.id}',
            );
          },
          text: 'Edit Profile',
        ),
      ],
    );
  }
}
