import 'package:app/app/admin/banner/admin_banners.dart';
import 'package:app/app/admin/dashboard/dashboard_controller.dart';
import 'package:app/app/admin/orders/admin_orders.dart';
import 'package:app/app/admin/products/admin_products.dart';
import 'package:app/app/admin/utils/dashboard_box.dart';
import 'package:app/app/admin/vendors/admin_vendor.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});
  final DashboardController _dashboardController = Get.put(
    DashboardController(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Dashboard'),

          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              Obx(() {
                return DashboardBox(
                  title: "Total Products",
                  value: "${_dashboardController.totalProducts}",
                  widget: AdminProductsListPage(),
                );
              }),
              Obx(() {
                return DashboardBox(
                  title: "Total Orders",
                  value: "${_dashboardController.totalOrders}",
                  widget: AdminOrders(),
                );
              }),
              DashboardBox(
                title: "Vendors",
                value: "35",
                widget: AdminVendor(),
              ),
              DashboardBox(
                title: "Revenue",
                value: "₹50,000",
                widget: AdminDashboard(),
              ),
              Obx(() {
                return DashboardBox(
                  title: "Banners",
                  value: "${_dashboardController.totalBanner}",
                  widget: AdminBanners(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
