import 'package:flutter/material.dart';

class UnJBox extends StatelessWidget {
  const UnJBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF42A5F5)], // Blue shades
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.4),
            offset: const Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        "UNJ",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
