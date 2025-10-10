import 'package:app/app/admin/vendors/admin_vendor_controller.dart';
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
              children: [
                TextFormField(
                  controller: controller.vendorName,
                  decoration: const InputDecoration(labelText: "Vendor Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter vendor name" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.businessName,
                  decoration: const InputDecoration(labelText: "Business Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter business name" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.address,
                  decoration: const InputDecoration(labelText: "Address"),
                  validator: (value) => value!.isEmpty ? "Enter address" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.gstPanAadhaar,
                  decoration: const InputDecoration(
                    labelText: "GST / PAN / Aadhaar",
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter ID details" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.pincode,
                  decoration: const InputDecoration(labelText: "Pincode"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter pincode" : null,
                ),
                const SizedBox(height: 16),

                /// Plan selector
                Obx(
                  () => DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Select Plan"),
                    initialValue: controller.selectedPlan.value,
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

                /// Dynamic mobile number fields
                TextFormField(
                  controller: controller.mobile1,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number 1",
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? "Enter mobile number" : null,
                ),
                SizedBox(height: 8),
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

                /// Banner upload (only for Max)
                Obx(
                  () => controller.selectedPlan.value == "Max"
                      ? InkWell(
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
                        )
                      : const SizedBox(),
                ),

                const SizedBox(height: 24),

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
