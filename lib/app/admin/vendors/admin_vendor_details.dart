import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminVendorDetails extends StatelessWidget {
  const AdminVendorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vendor Details"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Vendor Name',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '100',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Product Cat',
                style: TextStyle(
                  color: AppColors.secondaryColor.withAlpha(100),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                'Product Decsriptin',
                style: TextStyle(
                  color: AppColors.gray,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 4),
            ],
          ),
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
