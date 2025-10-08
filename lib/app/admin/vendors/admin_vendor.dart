import 'package:app/app/admin/auth/admin_login.dart';
import 'package:app/app/admin/utils/vendor_card.dart';
import 'package:app/app/admin/vendors/admin_vendor_details.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toastification/toastification.dart';

class AdminVendor extends StatelessWidget {
  const AdminVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Vendors'), centerTitle: true),
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
              return VendorCard(
                imageUrl:
                    'https://www.venkateshwaragroup.in/vgiblog/wp-content/uploads/2023/04/Scope-for-Agriculture.jpg',
                title: "Vendor Name",
                category: "cat",
                pincode: '10',
                onTap: () {
                  Get.to(() => AdminVendorDetails());
                },
                onDelete: () {},
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
              Get.to(() => AdminLogin());
              // toastification.show(
              //   context: context,
              //   type: ToastificationType.success,
              //   style: ToastificationStyle.minimal,
              //   title: Text('Add Vendor'),
              //   autoCloseDuration: Duration(seconds: 1),
              // );
            },
            icon: Icon(Iconsax.add, color: AppColors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
