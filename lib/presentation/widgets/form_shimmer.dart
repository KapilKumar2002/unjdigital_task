import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FormShimmer extends StatelessWidget {
  const FormShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          // Shimmer for Name
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 60,
              width: 200,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),

          // Shimmer for Email
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 60,
              width: 250,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),

          // Shimmer for Phone
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 60,
              width: 220,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),

          // Shimmer for Save Button
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 70,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
