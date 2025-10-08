import 'package:app/app/admin/orders/admin_order_details.dart';
import 'package:app/app/admin/utils/orders_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Orders'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return OrderCards(
                productName: 'Product Name',
                price: '100',
                onAccept: () {
                  toastification.show(
                    context: context,
                    autoCloseDuration: const Duration(seconds: 1),
                    icon: const Icon(Icons.check),
                    type: ToastificationType.success,
                    style: ToastificationStyle.minimal,
                    title: Text('Order Accepted'),
                  );
                },
                onDelete: () {
                  toastification.show(
                    context: context,
                    icon: const Icon(Icons.check),
                    type: ToastificationType.error,
                    autoCloseDuration: const Duration(seconds: 1),
                    style: ToastificationStyle.minimal,
                    title: Text('Order Deleted'),
                  );
                },
                onTap: () {
                  Get.to(() => AdminOrderDetails());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
