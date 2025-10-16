import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminVendorController extends GetxController {
  final vendors = <Map<String, dynamic>>[].obs;
  final vendor = <String, dynamic>{}.obs;
  final _firebase = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    vendors.bindStream(
      _firebase
          .collection('businesses')
          .orderBy('order', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => {"id": doc.id, ...doc.data()})
                .toList(),
          ),
    );
  }

  Future<void> getVendorDetailsById(String id) async {
    try {
      final docSnapshot = await _firebase
          .collection('businesses')
          .doc(id)
          .get();
      if (docSnapshot.exists) {
        vendor.value = {"id": docSnapshot.id, ...docSnapshot.data()!};
      } else {
        vendor.clear(); // Clear if no data found
      }
    } catch (e) {
      print(e);
      return;
    }
  }
}
