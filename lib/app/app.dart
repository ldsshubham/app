import 'package:app/app/admin/dashboard/views/dashboard.dart';
import 'package:app/constants/strings.dart';
import 'package:app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AdminDashboard(),
      title: AppString.appName,
    );
  }
}
