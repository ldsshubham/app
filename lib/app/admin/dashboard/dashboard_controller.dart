import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxInt totalProducts = 0.obs;
  final RxInt totalOrders = 0.obs;
  final RxInt totalVendors = 0.obs;
  final RxDouble totalRevenue = 0.0.obs;
  final RxInt totalBanner = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashBoard(); // Call fetch when controller initializes
  }

  Future<void> fetchDashBoard() async {
    try {
      _firestore.collection('banners').snapshots().listen((snapshot) {
        totalBanner.value = snapshot.docs.length;
      });
      _firestore.collection('vendor').snapshots().listen((snapshot) {
        totalVendors.value = snapshot.docs.length;
      });
      _firestore.collection('orders').snapshots().listen((snapshot) {
        totalOrders.value = snapshot.docs.length;
      });
      _firestore.collection('products').snapshots().listen((snapshot) {
        totalProducts.value = snapshot.docs.length;
      });
    } catch (e) {
      print(e);
      return;
    }
  }
}
