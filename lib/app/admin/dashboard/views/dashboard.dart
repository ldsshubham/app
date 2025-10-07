import 'package:app/app/admin/orders/admin_orders.dart';
import 'package:app/app/admin/products/admin_products.dart';
import 'package:app/app/admin/utils/dashboard_box.dart';
import 'package:app/app/admin/vendors/admin_vendor.dart';

import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
            children: const [
              DashboardBox(
                title: "Total Products",
                value: "100",
                widget: AdminProductsListPage(),
              ),
              DashboardBox(
                title: "Total Orders",
                value: "250",
                widget: AdminOrders(),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
