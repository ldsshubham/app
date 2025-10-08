import 'package:app/app/admin/products/admin_add_products.dart';
import 'package:app/app/admin/products/admin_product_details.dart';
import 'package:app/app/admin/utils/product_card.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toastification/toastification.dart';

class AdminProductsListPage extends StatelessWidget {
  const AdminProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Products'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),

          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 230,
            ),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ProductCard(
                imageUrl:
                    'https://www.venkateshwaragroup.in/vgiblog/wp-content/uploads/2023/04/Scope-for-Agriculture.jpg',
                title: "Product",
                category: "cat",
                price: '10',
                onTap: () {
                  Get.to(() => AdminProductDetails());
                },
                onDelete: () {
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
          ),
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
