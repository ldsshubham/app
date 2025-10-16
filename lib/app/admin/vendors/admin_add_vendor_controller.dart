import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BusinessRegistrationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Razorpay _razorpay = Razorpay();
  final ImagePicker picker = ImagePicker();

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
  final RxString profileImgUrl = ''.obs;
  final RxString bannerImgUrl = ''.obs;
  final RxBool isLoading = false.obs;

  final planPayment = 0.obs;
  final order = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  // 🔹 Image Pickers
  Future<void> pickBannerImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) selectedBanner.value = File(image.path);
  }

  Future<void> pickProfileImg() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) selectedProfile.value = File(image.path);
  }

  // 🔹 Upload Image
  Future<String> uploadPicture(File file, {required String type}) async {
    try {
      final storage = FirebaseStorage.instance;
      final folder = type.toLowerCase();
      final filename = "${folder}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      final fileRef = storage.ref().child("$folder/$filename");
      final uploadTask = await fileRef.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      if (type == "banner") {
        bannerImgUrl.value = downloadUrl;
        await _firestore.collection("banners").add({
          "bannerUrl": downloadUrl,
          "bannerTitle": type,
          "createdAt": DateTime.now(),
        });
      } else {
        profileImgUrl.value = downloadUrl;
      }

      toastification.show(
        autoCloseDuration: const Duration(seconds: 1),
        title: Text("Success image uploaded $type"),
        style: ToastificationStyle.minimal,
        type: ToastificationType.success,
      );

      return downloadUrl;
    } catch (e) {
      Get.snackbar("Error", "Failed to upload $type image: $e");
      return '';
    }
  }

  // 🔹 Plan Details
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
        return planPayment.value = 199; // in ₹
      case "Max":
        return planPayment.value = 299;
      default:
        return planPayment.value = 0;
    }
  }

  // 🔹 Main Submit Function
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

    // if Premium plan, require second number
    if (selectedPlan.value == "Premium" && mobile2.text.isEmpty) {
      Get.snackbar("Error", "Enter second mobile number for Premium plan");
      return;
    }

    // 🔸 If Free Plan → Directly add
    if (selectedPlan.value == "Free") {
      await _addBusinessToFirestore();
      return;
    }

    // 🔸 If Paid Plan → Trigger Razorpay Payment
    _openCheckout();
  }

  // 🔹 Razorpay Checkout
  void _openCheckout() {
    final amountInPaise = planSubs * 100; // Convert ₹ to paise

    var options = {
      'key': 'rzp_test_iAGSZziECBXhHq', // Replace with your Razorpay key
      'amount': amountInPaise,
      'name': 'Vendor Registration',
      'description': '${selectedPlan.value} Plan Subscription',
      'prefill': {'contact': mobile1.text, 'email': 'vendor@example.com'},
      'theme': {'color': '#3399cc'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('⚠️ Razorpay Error: $e');
    }
  }

  // 🔹 Payment Callbacks
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    toastification.show(
      title: const Text("Payment Successful ✅"),
      style: ToastificationStyle.minimal,
      type: ToastificationType.success,
    );

    // After successful payment → add business
    await _addBusinessToFirestore();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", "Please try again later");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", "${response.walletName}");
  }

  // 🔹 Add Data to Firestore
  Future<void> _addBusinessToFirestore() async {
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
        "expiryDate": DateTime.now().add(const Duration(days: 30)),
        "canAddBanners": selectedPlan.value == "Max",
      };

      await _firestore.collection("businesses").add(businessData);

      Get.snackbar("Success", "Business registered successfully");

      _clearForm();
    } catch (e) {
      Get.snackbar("Error", "Failed to register: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _clearForm() {
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
    selectedProfile.value = null;
  }
}
