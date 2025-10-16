import 'package:app/app/admin/auth/admin_login.dart';
import 'package:app/app/customer/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = <Widget>[
    const HomeScreen(),
    const Center(child: Text('🔍 Search Page')),
    const Center(child: Text('🛒 Orders Page')),
    const Center(child: Text('🛒 Registration page')),
    AdminLogin(),
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
