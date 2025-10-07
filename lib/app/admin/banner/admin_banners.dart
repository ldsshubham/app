import 'package:flutter/material.dart';

class AdminBanners extends StatelessWidget {
  const AdminBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Banners'), centerTitle: true),
      ),
    );
  }
}
