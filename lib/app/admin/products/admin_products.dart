import 'package:app/app/admin/products/admin_add_products.dart';
import 'package:app/app/admin/products/admin_product_details.dart';
import 'package:app/app/admin/products/admin_products_controller.dart';
import 'package:app/app/admin/utils/product_card.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toastification/toastification.dart';

class AdminProductsListPage extends StatelessWidget {
  AdminProductsListPage({super.key});
  final AdminProductsController controller = Get.put(AdminProductsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Products'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),

          child: Obx(() {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 230,
              ),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return ProductCard(
                  imageUrl:
                      product['productImageUrl'] ??
                      "https://i0.wp.com/kudos.fastcompany.com/wp-content/uploads/2025/04/placeholder.png?ssl=1",
                  title: product['productName'] ?? "Product Name",
                  category: product['productCategory'] ?? "Category",
                  price: "${product['productPrice']}",
                  onTap: () {
                    Get.to(() => AdminProductDetails(id: product['productId']));
                  },
                  onDelete: () {
                    controller.deleteProduct(
                      product['id'],
                      product['productImageUrl'] ?? '',
                    );
                    toastification.show(
                      context: context,
                      type: ToastificationType.success,
                      autoCloseDuration: Duration(seconds: 1),
                      title: Text('Product Delete'),
                      style: ToastificationStyle.minimal,
                      icon: Icon(Icons.check),
                    );
                  },
                );
              },
            );
          }),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: () {
              Get.to(() => AdminAddProducts());
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.minimal,
                title: Text('Add Product'),
                autoCloseDuration: Duration(seconds: 1),
              );
            },
            icon: Icon(Iconsax.add, color: AppColors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
