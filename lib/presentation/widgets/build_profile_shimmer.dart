import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuildProfileShimmer extends StatelessWidget {
  const BuildProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          // Shimmer for Profile Picture
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // Shimmer for Name
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 200,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),

          // Shimmer for Email
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 250,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),

          // Shimmer for Phone
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 220,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),

          // Shimmer for Address
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 240,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),

          // Shimmer for Buttons (Edit, Save, etc.)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
