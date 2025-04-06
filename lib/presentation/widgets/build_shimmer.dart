import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuildShimmer extends StatelessWidget {
  const BuildShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10, // Show 5 shimmer items
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 24.0,
              ),
              title: Container(
                width: 120,
                height: 12.0,
                color: Colors.grey,
              ),
              subtitle: Container(
                width: 80,
                height: 10.0,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
