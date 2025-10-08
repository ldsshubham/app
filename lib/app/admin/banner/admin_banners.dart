import 'package:app/app/admin/banner/add_banner.dart';
import 'package:app/app/admin/banner/banner_controller.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminBanners extends StatelessWidget {
  const AdminBanners({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController controller = Get.put(BannerController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Banners'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(() {
            return controller.banners.isEmpty
                ? const Center(
                    child: Text(
                      "No banners found",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : GridView.builder(
                    itemCount: controller.banners.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5,
                        ),
                    itemBuilder: (context, index) {
                      final banner = controller.banners[index];
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(banner),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                controller.banners.removeAt(index);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
          }),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.green,
          ),
          child: IconButton(
            onPressed: () {
              Get.to(() => AddBanner());
            },
            icon: Icon(Iconsax.add, color: AppColors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
