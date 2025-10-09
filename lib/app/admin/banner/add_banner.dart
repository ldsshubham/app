import 'package:app/app/admin/banner/banner_controller.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddBanner extends StatelessWidget {
  AddBanner({super.key});

  final BannerController controller = Get.put(BannerController());
  final TextEditingController titleField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Banner'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Banner picker section
            Obx(
              () => InkWell(
                onTap: controller.pickBannerImage,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.gray.withOpacity(0.2),
                    border: Border.all(color: AppColors.primaryColor, width: 1),
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
                              "Tap to upload banner",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Banner title input
            TextField(
              controller: titleField,
              onChanged: (val) => controller.titleController.value = val,
              decoration: InputDecoration(
                labelText: "Banner Title (optional)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Upload button
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null // disable button while uploading
                      : controller.uploadBanner,
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
                    controller.isLoading.value ? "Uploading..." : "Upload",
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text("Uploaded Banner"),
          ],
        ),
      ),
    );
  }
}
