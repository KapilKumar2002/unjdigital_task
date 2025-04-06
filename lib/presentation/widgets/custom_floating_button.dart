import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blueAccent, // Custom color for the button
      elevation: 10, // Strong shadow effect for depth
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12), // Rounded corners for a modern feel
      ),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30, // Slightly larger icon for better visibility
      ),
    );
  }
}
