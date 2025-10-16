import 'package:app/app/admin/banner/banner_controller.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Banners extends StatelessWidget {
  Banners({super.key});
  final BannerController controller = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final banners = controller.uploadBanners;

      if (banners.isEmpty) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.gray.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: const Text(
            "No banners available",
            style: TextStyle(color: Colors.black54),
          ),
        );
      }

      return Column(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                final banner = banners[index];
                return Image.network(
                  banner.url,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 40)),
                );
              },
              onPageChanged: (index) => controller.currentPage.value = index,
            ),
          ),
          const SizedBox(height: 8),
          SmoothPageIndicator(
            controller: controller.pageController,
            count: banners.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primaryColor,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ],
      );
    });
  }
}
