import 'package:app/app/admin/products/admin_products_controller.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminProductDetails extends StatelessWidget {
  final String id;
  AdminProductDetails({super.key, required this.id});
  final AdminProductsController productsController = Get.put(
    AdminProductsController(),
  );
  @override
  Widget build(BuildContext context) {
    productsController.fetchProductDetails(id);

    return Scaffold(
      appBar: AppBar(title: Text("Product Details"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                        productsController.product['productImageUrl'] ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  productsController.product['productName'] ?? 'Product Name',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  productsController.product['productPrice'] != null
                      ? '${productsController.product['productPrice']}'
                      : '0.00',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  productsController.product['productCategory'] ?? 'Category',
                  style: TextStyle(
                    color: AppColors.secondaryColor.withAlpha(100),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  productsController.product['productDescription'] ??
                      'Product Description',
                  style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 4),
              ],
            );
          }),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: AppColors.green,
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Iconsax.edit, color: AppColors.white),
        ),
      ),
    );
  }
}
