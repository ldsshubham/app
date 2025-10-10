import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxInt totalProducts = 0.obs;
  final RxInt totalOrders = 0.obs;
  final RxInt totalVendors = 0.obs;
  final RxDouble totalRevenue = 0.0.obs;
  final RxInt totalBanner = 0.obs;
  late StreamSubscription _bannersSub;
  late StreamSubscription _vendorsSub;
  late StreamSubscription _ordersSub;
  late StreamSubscription _productsSub;

  @override
  void onInit() {
    super.onInit();
    fetchDashBoard(); // Call fetch when controller initializes
  }

  @override
  void onClose() {
    _bannersSub.cancel();
    _vendorsSub.cancel();
    _ordersSub.cancel();
    _productsSub.cancel();
    super.onClose();
  }

  Future<void> fetchDashBoard() async {
    try {
      _bannersSub = _firestore.collection('banners').snapshots().listen((
        snapshot,
      ) {
        totalBanner.value = snapshot.docs.length;
      });
      _vendorsSub = _firestore.collection('vendor').snapshots().listen((
        snapshot,
      ) {
        totalVendors.value = snapshot.docs.length;
      });
      _ordersSub = _firestore.collection('orders').snapshots().listen((
        snapshot,
      ) {
        totalOrders.value = snapshot.docs.length;
      });
      _productsSub = _firestore.collection('products').snapshots().listen((
        snapshot,
      ) {
        totalProducts.value = snapshot.docs.length;
      });
    } catch (e) {
      print(e);
      return;
    }
  }
}
