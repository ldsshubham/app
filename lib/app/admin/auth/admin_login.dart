import 'package:app/app/admin/auth/admin_login_controller.dart';
import 'package:app/app/admin/dashboard/dashboard.dart';
import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  final AdminLoginController loginController = Get.put(AdminLoginController());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'User Login',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: loginController.emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  hintText: 'Admin Id',
                  hintStyle: TextStyle(color: AppColors.gray),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Emal Id";
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Obx(
                () => TextFormField(
                  obscureText: loginController.isPasswordHidden.value,
                  controller: loginController.passwordController,

                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    hintText: "***********",
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginController.isPasswordHidden.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                      ),
                      onPressed: () {
                        loginController.isPasswordHidden.toggle();
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      bool success = await loginController.loginAdmin();
                      if (success) {
                        Get.snackbar(
                          'Sucess',
                          "Successfully Logged In",
                          colorText: AppColors.white,
                          backgroundColor: AppColors.green,
                        );
                        Get.offAll(() => AdminDashboard());
                      } else {
                        Get.snackbar(
                          'Login Error',
                          "Login Unsuccessfull",
                          colorText: AppColors.white,
                          backgroundColor: AppColors.error,
                        );
                        print('something went wronf');
                      }
                    }
                  },
                  child: Obx(() {
                    return loginController.isLoading.value
                        ? Text('Loading....')
                        : Text("Login");
                  }),
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  loginController.resetPassword();
                },
                child: Text('Reset password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
