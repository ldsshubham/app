import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmersCard {
  Widget _buildHeadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 24,
        width: double.infinity,
      ),
    );
  }
}
