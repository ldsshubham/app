import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BusinessRegistrationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController vendorName = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController gstPanAadhaar = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController mobile1 = TextEditingController();
  final TextEditingController mobile2 = TextEditingController();
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
      final storage = FirebaseStorage.instance;
      final folder = type.toLowerCase() == "banner" ? "banners" : "profiles";
      final filename = "${folder}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      final fileRef = storage.ref().child("$folder/$filename");
      final uploadTask = await fileRef.putFile(file);
      return '';
    } catch (e) {
      return '';
    }
  }

  int get planOrder {
    switch (selectedPlan.value) {
      case "Premium":
        return 1;
      case "Max":
        return 2;
      default:
        return 0;
    }
  }

  int get planSubs {
    switch (selectedPlan.value) {
      case "Premium":
        return 199;
      case "Max":
        return 299;
      default:
        return 0;
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
        "mobileNumbers": selectedPlan.value == "Premium"
            ? [mobile1.text, mobile2.text]
            : [mobile1.text],
        "createdAt": DateTime.now(),
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
      selectedPlan.value = "Free";
      selectedBanner.value = null;
    } catch (e) {
      Get.snackbar("Error", "Failed to register: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
