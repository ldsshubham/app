import 'dart:io';
import 'package:app/app/admin/banner/banner_model.dart';
import 'package:app/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BannerController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  final isLoading = false.obs;
  final uploadBanners = <BannerModel>[].obs;
  final titleController = ''.obs;
  final selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    uploadBanners.bindStream(
      FirebaseFirestore.instance
          .collection('banners')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => BannerModel.fromJson(doc.data(), doc.id))
                .toList(),
          ),
    );
  }

  Future<void> pickBannerImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> uploadBanner() async {
    if (selectedImage.value == null) {
      Get.snackbar(
        'Error',
        "Please Upload Image",
        colorText: AppColors.white,
        backgroundColor: AppColors.error,
      );
      return;
    }

    try {
      isLoading.value = true;
      final fileName = "banner_${DateTime.now().millisecondsSinceEpoch}.jpg";
      final bannerRef = storageRef.child("banner/$fileName");
      final uploadTask = await bannerRef.putFile(selectedImage.value!);
      final bannerDownloadUrl = await uploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("banners").add({
        "bannerUrl": bannerDownloadUrl,
        "bannerTitle": titleController.value,
        "createdAt": DateTime.now(),
      });

      Get.snackbar(
        'Success',
        "Banner uploaded successfully!",
        backgroundColor: AppColors.green,
        colorText: AppColors.white,
      );
      selectedImage.value = null;
      titleController.value = '';
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBanner(String id) async {
    // Instantly remove from UI first (optimistic update)
    final deletedIndex = uploadBanners.indexWhere((banner) => banner.id == id);
    if (deletedIndex == -1) return;

    final deletedBanner = uploadBanners[deletedIndex];
    uploadBanners.removeAt(deletedIndex);

    try {
      // Delete from Firestore (in background)
      await FirebaseFirestore.instance.collection('banners').doc(id).delete();

      // Optional: delete the image from Firebase Storage as well (optional optimization)
      // await FirebaseStorage.instance.refFromURL(deletedBanner.url).delete();

      Get.snackbar(
        'Success',
        'Banner deleted successfully!',
        backgroundColor: AppColors.green,
        colorText: AppColors.white,
      );
    } catch (e) {
      // Rollback if Firestore deletion fails
      uploadBanners.insert(deletedIndex, deletedBanner);
      Get.snackbar(
        'Error',
        'Failed to delete banner: $e',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      print('Delete error: $e');
    }
  }
}
