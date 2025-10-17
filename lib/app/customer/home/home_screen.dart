import 'package:app/app/customer/dashboard/banner_component.dart';
import 'package:app/app/customer/dashboard/product_components.dart';
import 'package:app/app/customer/dashboard/vendor_component.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Banners(), ProductComponents(), VendorComponent()],
          ),
        ),
      ),
    );
  }
}
