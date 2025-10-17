import 'package:app/app/customer/dashboard/dashcontroller.dart';
import 'package:app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductComponents extends StatelessWidget {
  ProductComponents({super.key});
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return controller.isLoading.value
                  ? _buildHeadingShimmer()
                  : const Text(
                      'Featured Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
            }),

            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                return controller.isLoading.value
                    ? _buildShimmerList()
                    : _buildProductList();
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Shimmer placeholder
  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }

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

  /// ✅ Actual product list
  Widget _buildProductList() {
    return Obx(() {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return Container(
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            width: 150,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: Center(
                    child: Image(
                      image: NetworkImage(
                        product['productImageUrl'] ??
                            "https://i0.wp.com/kudos.fastcompany.com/wp-content/uploads/2025/04/placeholder.png?ssl=1",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product['productName'] ?? "Product Name"}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),

                      Text(
                        "${AppString.ruppee} ${product['productPrice']}",
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
