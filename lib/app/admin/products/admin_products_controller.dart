import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminProductsController extends GetxController {
  final products = <Map<String, dynamic>>[].obs;
  final product = <String, dynamic>{}.obs;
  final storageref = FirebaseStorage.instance.ref();
  final _firebase = FirebaseFirestore.instance;
  final isLoading = false.obs;
  final selectedImage = Rx<File?>(null);
  final TextEditingController productName = TextEditingController();
  final TextEditingController productDescription = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productCategory = TextEditingController();
  final TextEditingController productImageUrl = TextEditingController();
  final TextEditingController productUnit = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final RxString productImgUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    products.bindStream(
      _firebase
          .collection('products')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => {"id": doc.id, ...doc.data()})
                .toList(),
          ),
    );
  }

  Future<void> pickProductImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the selected image file
      selectedImage.value = File(image.path);
    }
  }

  Future<void> uploadProductImage() async {
    if (selectedImage.value == null) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }
    try {
      isLoading.value = true;
      final fileName = "banner_${DateTime.now().millisecondsSinceEpoch}.jpg";
      final productRef = storageref.child("products/$fileName");
      final uploadTask = await productRef.putFile(selectedImage.value!);
      productImgUrl.value = await uploadTask.ref.getDownloadURL();
      Get.snackbar("Success", "Image uploaded successfully");
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // add Products
  Future<void> addProduct() async {
    if (productName.text.isEmpty ||
        productDescription.text.isEmpty ||
        productPrice.text.isEmpty ||
        productCategory.text.isEmpty ||
        productUnit.text.isEmpty ||
        productImgUrl.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }
    try {
      isLoading.value = true;
      final docRef = await _firebase.collection("products").add({
        "productName": productName.text,
        "productDescription": productDescription.text,
        "productPrice": double.parse(productPrice.text),
        "productCategory": productCategory.text,
        "productImageUrl": productImgUrl.value,
        "productUnit": productUnit.text,
        "createdAt": DateTime.now(),
      });
      print(docRef);

      await docRef.update({"productId": docRef.id});
      Get.snackbar('Success', 'Product added successfully');
      productName.clear();
      productDescription.clear();
      productPrice.clear();
      productCategory.clear();
      productUnit.clear();
      selectedImage.value = null;
      productImgUrl.value = '';
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // delete products

  Future<void> deleteProduct(String id, String imageUrl) async {
    final deleteIndex = products.indexWhere((product) => product['id'] == id);
    if (deleteIndex == -1) return;

    final deletedProduct = products[deleteIndex];
    products.removeAt(deleteIndex);
    try {
      // Delete Firestore document
      await _firebase.collection('products').doc(id).delete();

      // Delete from Firebase Storage if image exists
      if (imageUrl.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }
    } catch (e) {
      return;
    }
  }

  // Get prorduct by id

  Future<void> fetchProductDetails(String id) async {
    try {
      await _firebase.collection('products').doc(id).get().then((doc) {
        if (doc.exists) {
          product.value = {"id": doc.id, ...doc.data()!};
        } else {
          Get.snackbar('Error', 'Product not found');
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
