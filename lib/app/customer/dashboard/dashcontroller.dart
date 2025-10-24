import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class DashboardController extends GetxController {
  final isLoading = false.obs;
  final products = <Map<String, dynamic>>[].obs;
  final vendors = <Map<String, dynamic>>[].obs;
  final product = <Map<String, dynamic>>{}.obs;
  final vendor = <Map<String, dynamic>>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchProducts();
    _fetchBusiness();
  }

  _fetchProducts() async {
    try {
      isLoading.value = true;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .limit(10)
          .get();

      products.value = querySnapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      toastification.show(
        title: Text('Somethin went wrong'),

        type: ToastificationType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  _fetchBusiness() async {
    try {
      isLoading.value = true;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('businesses')
          .limit(10)
          .get();

      vendors.value = querySnapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      toastification.show(
        title: Text('Somethin went wrong'),
        type: ToastificationType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
