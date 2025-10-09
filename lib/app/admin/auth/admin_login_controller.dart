import 'package:app/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AdminLoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  // Create user with email and password
  Future<bool> createAdmin() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      final User? user = credential.user;
      if (user != null) {
        print("Admin created successfully! UID: ${user.uid}");
        // You can also store user details in Firestore here if needed
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Weak Password",
          "Weak Password",
          colorText: AppColors.white,
          backgroundColor: AppColors.error,
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar(
          "Account Already Exist",
          "Account Already Exists",
          colorText: AppColors.white,
          backgroundColor: AppColors.warning,
        );
        // Get.snackbar("Account Already Exist", "Account Already Exists", colorText: AppColors.white, backgroundColor: AppColors.warning);
        // Get.snackbar("Account Already Exist", "Account Already Exists", colorText: AppColors.white, backgroundColor: AppColors.warning);
      }
      return false;
    } catch (e) {
      print('This is the error $e');
      return false;
    }
  }

  //  Login user with email & password
  Future<bool> loginAdmin() async {
    try {
      isLoading.value = true;
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = userCredential.user;
      if (user != null) {
        print("✅ Admin logged in successfully! UID: ${user.uid}");
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "User Not Found",
          "No user found for that email.",
          colorText: AppColors.white,
          backgroundColor: AppColors.error,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Wrong Password",
          "Incorrect password provided.",
          colorText: AppColors.white,
          backgroundColor: AppColors.error,
        );
      } else {
        Get.snackbar(
          "Login Failed",
          "Not an admin",
          colorText: AppColors.white,
          backgroundColor: AppColors.error,
        );
      }
      return false;
    } catch (e) {
      print("❌ Login error: $e");
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: AppColors.white,
        backgroundColor: AppColors.error,
      );
      return false;
    }
  }

  // Reset password

  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Email Required",
        "Please enter your registered email address.",
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Password Reset Email Sent",
        "Check your inbox to reset your password.",
        colorText: AppColors.white,
        backgroundColor: AppColors.green,
      );
      print("✅ Password reset email sent to $email");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("User Not Found", "No user found for that email address.");
      } else {
        Get.snackbar("Error", e.message ?? "Something went wrong.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
