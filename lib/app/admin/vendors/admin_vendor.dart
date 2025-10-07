import 'package:flutter/material.dart';

class AdminVendor extends StatelessWidget {
  const AdminVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Vendors'), centerTitle: true),
      ),
    );
  }
}
