import 'package:flutter/material.dart';

class CustomUserTile extends StatelessWidget {
  final String name;
  final String email;
  final String userId;
  final VoidCallback onTap;

  const CustomUserTile({
    Key? key,
    required this.name,
    required this.email,
    required this.userId,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        onTap: onTap,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.blueAccent,
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
