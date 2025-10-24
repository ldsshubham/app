import 'package:app/app/admin/utils/vendor_card.dart';
import 'package:app/app/admin/vendors/admin_add_vendor.dart';
import 'package:app/app/admin/vendors/admin_vendor_controller.dart';
import 'package:app/app/admin/vendors/admin_vendor_details.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminVendor extends StatelessWidget {
  AdminVendor({super.key});
  final AdminVendorController controller = Get.put(AdminVendorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Vendors'), centerTitle: true),
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
              itemCount: controller.vendors.length,
              itemBuilder: (context, index) {
                final vendor = controller.vendors[index];
                return VendorCard(
                  imageUrl:
                      vendor['profileImgUrl'] ??
                      "https://i0.wp.com/kudos.fastcompany.com/wp-content/uploads/2025/04/placeholder.png?ssl=1",
                  title: vendor['businessName'],
                  category: vendor['address'],
                  pincode: vendor['pincode'],
                  onTap: () {
                    Get.to(() => AdminVendorDetails(vendorId: vendor['id']));
                  },
                  onDelete: () {},
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
              Get.to(() => BusinessRegistrationScreen());
            },
            icon: Icon(Iconsax.add, color: AppColors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
