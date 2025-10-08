import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BannerController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();

  var banners = [
    "https://via.placeholder.com/300x150.png?text=Banner+1",
    "https://via.placeholder.com/300x150.png?text=Banner+2",
    "https://via.placeholder.com/300x150.png?text=Banner+3",
  ].obs;
  final titleController = ''.obs;
  final selectedImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickBannerImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void uploadBanner() {
    if (selectedImage.value == null) {
      Get.snackbar("Error", "Please select a banner image first");
      return;
    }
    Get.snackbar("Success", "Banner uploaded successfully!");
    print("Uploading banner: ${titleController.value}");
  }
}
