import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class BusinessRegistrationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController vendorName = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController gstPanAadhaar = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController mobile1 = TextEditingController();
  final TextEditingController mobile2 = TextEditingController();
  final planPayment = 0.obs;
  final profileImgUrl = ''.obs;
  final order = 0.obs;
  final bannerImgUrl = ''.obs;
  final RxString selectedPlan = "Free".obs;
  final Rx<File?> selectedBanner = Rx<File?>(null);
  final Rx<File?> selectedProfile = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  final ImagePicker picker = ImagePicker();

  Future<void> pickBannerImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedBanner.value = File(image.path);
    }
  }

  Future<void> pickProfileImg() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedProfile.value = File(image.path);
    }
  }

  Future<String> uploadPicture(File file, {required String type}) async {
    try {
      if (!file.existsSync()) {
        print("❌ File does not exist: ${file.path}");
        Get.snackbar("Error", "Selected $type image file not found");
        return '';
      }
      final storage = FirebaseStorage.instance;
      final folder = type.toLowerCase() == "banner" ? "banner" : "profiles";
      final filename = "${folder}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      final fileRef = storage.ref().child("$folder/$filename");
      final uploadTask = await fileRef.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      type == "banner"
          ? bannerImgUrl.value = downloadUrl
          : profileImgUrl.value = downloadUrl;
      type == "bannner"
          ? await FirebaseFirestore.instance.collection("banners").add({
              "bannerUrl": downloadUrl,
              "bannerTitle": type,
              "createdAt": DateTime.now(),
            })
          : null;

      toastification.show(
        autoCloseDuration: Duration(seconds: 1),
        title: Text("Success image uploaded $type"),
        style: ToastificationStyle.minimal,
        type: ToastificationType.success,
      );
      return downloadUrl;
    } catch (e) {
      print("Error uploading $type image: $e");
      Get.snackbar("Error", "Failed to upload $type image");
      return '';
    }
  }

  int get planOrder {
    switch (selectedPlan.value) {
      case "Premium":
        return order.value = 1;
      case "Max":
        return order.value = 2;
      default:
        return order.value = 0;
    }
  }

  int get planSubs {
    switch (selectedPlan.value) {
      case "Premium":
        return planPayment.value = 199;
      case "Max":
        return planPayment.value = 299;
      default:
        return planPayment.value = 0;
    }
  }

  Future<void> submitBusiness() async {
    if (vendorName.text.isEmpty ||
        businessName.text.isEmpty ||
        address.text.isEmpty ||
        gstPanAadhaar.text.isEmpty ||
        pincode.text.isEmpty ||
        mobile1.text.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields");
      return;
    }

    if (selectedPlan.value == "Premium" && mobile2.text.isEmpty) {
      Get.snackbar("Error", "Enter second mobile number for Premium plan");
      return;
    }

    try {
      isLoading.value = true;
      final businessData = {
        "vendorName": vendorName.text,
        "businessName": businessName.text,
        "address": address.text,
        "gst_pan_aadhaar": gstPanAadhaar.text,
        "pincode": pincode.text,
        "plan": selectedPlan.value,
        "order": planOrder,
        "is_active": true,
        "profileImgUrl": profileImgUrl.value,
        "bannerImgUrl": bannerImgUrl.value,
        "mobileNumbers": selectedPlan.value == "Premium"
            ? [mobile1.text, mobile2.text]
            : [mobile1.text],
        "createdAt": DateTime.now(),
        "expiryDate": DateTime.now().add(Duration(days: 30)),
      };

      // If Max Plan — store with banner support flag
      if (selectedPlan.value == "Max") {
        businessData["canAddBanners"] = true;
      }

      await _firestore.collection("businesses").add(businessData);
      Get.snackbar("Success", "Business registered successfully");
      vendorName.clear();
      businessName.clear();
      address.clear();
      gstPanAadhaar.clear();
      pincode.clear();
      mobile1.clear();
      mobile2.clear();
      profileImgUrl.value = '';
      bannerImgUrl.value = '';
      selectedPlan.value = "Free";
      selectedBanner.value = null;
    } catch (e) {
      Get.snackbar("Error", "Failed to register: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
