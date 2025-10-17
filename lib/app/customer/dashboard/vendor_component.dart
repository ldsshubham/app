import 'package:app/app/customer/dashboard/dashcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VendorComponent extends StatelessWidget {
  VendorComponent({super.key});
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
                      'Featured Adhtiyas',
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
                    : _buildVendorList();
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

  /// ✅ Actual Vendor list
  Widget _buildVendorList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
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
                child: const Center(
                  child: Image(
                    image: NetworkImage(
                      'https://play-lh.googleusercontent.com/pR3AhTl1bOz8anFPzWj3O6RucXldUqrhOQVkCRpnmtfVUcHiyPC_E4Yppb8s9GjGlg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Vendor Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "\$99.99",
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
  }
}
