import 'dart:io';

import 'package:app/app/admin/products/admin_products_controller.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAddProducts extends StatelessWidget {
  final AdminProductsController controller = AdminProductsController();
  AdminAddProducts({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.productName,
                  decoration: InputDecoration(labelText: "Product Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter product name" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.productDescription,
                  decoration: InputDecoration(labelText: "Product Description"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter description name" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.productCategory,
                  decoration: InputDecoration(labelText: "Product Category"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter product category" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.productPrice,
                  decoration: InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? "Enter product price" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.productUnit,
                  decoration: InputDecoration(labelText: "Unit"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter product unit" : null,
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Banner picker section
                    Obx(
                      () => InkWell(
                        onTap: controller.pickProductImage,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.gray.withOpacity(0.2),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: controller.selectedImage.value != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    controller.selectedImage.value as File,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate,
                                      size: 50,
                                      color: AppColors.primaryColor,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Tap to upload product image",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Banner title input

                    /// Upload button
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => OutlinedButton.icon(
                          onPressed: controller.isLoading.value
                              ? null // disable button while uploading
                              : controller.uploadProductImage,
                          icon: controller.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.cloud_upload),
                          label: Text(
                            controller.isLoading.value
                                ? "Uploading..."
                                : "Upload",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await controller.addProduct();
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Add Product',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
