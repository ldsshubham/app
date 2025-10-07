import 'package:flutter/material.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(title: Text('Orders'), centerTitle: true)),
    );
  }
}
