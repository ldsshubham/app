import 'package:app/app/admin/vendors/admin_add_vendor_controller.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessRegistrationScreen extends StatelessWidget {
  final BusinessRegistrationController controller = Get.put(
    BusinessRegistrationController(),
  );

  final _formKey = GlobalKey<FormState>();

  BusinessRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Business')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Profile Image
                Obx(() {
                  return InkWell(
                    onTap: controller.pickProfileImg,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      child: controller.selectedProfile.value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                controller.selectedProfile.value!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : const Center(
                              child: Text("Tap to upload profile image"),
                            ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (controller.selectedProfile.value != null) {
                        controller.uploadPicture(
                          controller.selectedProfile.value!,
                          type: "profile",
                        );
                      } else {
                        Get.snackbar("Error", "Please select an image first");
                      }
                    },
                    child: const Text('Upload Profile Picture'),
                  ),
                ),

                const SizedBox(height: 12),

                // 🔹 Vendor Info Fields
                TextFormField(
                  controller: controller.vendorName,
                  decoration: const InputDecoration(labelText: "Vendor Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter vendor name" : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.businessName,
                  decoration: const InputDecoration(labelText: "Business Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter business name" : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.address,
                  decoration: const InputDecoration(labelText: "Address"),
                  validator: (value) => value!.isEmpty ? "Enter address" : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.gstPanAadhaar,
                  decoration: const InputDecoration(
                    labelText: "GST / PAN / Aadhaar",
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter ID details" : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.pincode,
                  decoration: const InputDecoration(labelText: "Pincode"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter pincode" : null,
                ),

                const SizedBox(height: 16),

                // 🔹 Plan Selector
                Obx(
                  () => DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Select Plan"),
                    value: controller.selectedPlan.value,
                    items: const [
                      DropdownMenuItem(value: "Free", child: Text("Free")),
                      DropdownMenuItem(
                        value: "Premium",
                        child: Text("Premium"),
                      ),
                      DropdownMenuItem(value: "Max", child: Text("Max")),
                    ],
                    onChanged: (value) {
                      controller.selectedPlan.value = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // 🔹 Mobile Numbers
                TextFormField(
                  controller: controller.mobile1,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number 1",
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? "Enter mobile number" : null,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => controller.selectedPlan.value != "Free"
                      ? TextFormField(
                          controller: controller.mobile2,
                          decoration: const InputDecoration(
                            labelText: "Mobile Number 2 (Premium/Max)",
                          ),
                          keyboardType: TextInputType.phone,
                        )
                      : const SizedBox(),
                ),

                const SizedBox(height: 16),

                // 🔹 Banner Upload (for Max plan)
                Obx(
                  () => controller.selectedPlan.value == "Max"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: controller.pickBannerImage,
                              child: Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: controller.selectedBanner.value != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.file(
                                          controller.selectedBanner.value!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      )
                                    : const Center(
                                        child: Text("Tap to upload banner"),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (controller.selectedBanner.value != null) {
                                    controller.uploadPicture(
                                      controller.selectedBanner.value!,
                                      type: "banner",
                                    );
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Please select banner",
                                    );
                                  }
                                },
                                child: const Text('Upload Banner'),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),

                const SizedBox(height: 24),

                // 🔹 Submit Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await controller.submitBusiness();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Register Business',
                              style: TextStyle(fontSize: 16),
                            ),
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
