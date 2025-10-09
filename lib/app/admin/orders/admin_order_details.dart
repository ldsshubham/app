import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AdminOrderDetails extends StatelessWidget {
  const AdminOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Details"), centerTitle: true),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Product Name',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Product Cat',
                style: TextStyle(
                  color: AppColors.secondaryColor.withAlpha(100),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Product Decsriptin',
                style: TextStyle(
                  color: AppColors.gray,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),

              SizedBox(height: 4),
              Text(
                'Delivery Details',
                style: TextStyle(color: AppColors.green, fontSize: 16),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name:', style: TextStyle(color: AppColors.gray)),
                  Text(
                    'Shubham Mishrta',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Address:', style: TextStyle(color: AppColors.gray)),
                  Text(
                    '123, XYZ, Gyanpur, Bhadohi, Uttar Pradesh',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mobile Number:',
                    style: TextStyle(color: AppColors.gray),
                  ),
                  Text(
                    '+91 8299828343',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email:', style: TextStyle(color: AppColors.gray)),
                  Text('N/A', style: TextStyle(color: AppColors.primaryColor)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pincode:', style: TextStyle(color: AppColors.gray)),
                  Text(
                    '221304',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('City:', style: TextStyle(color: AppColors.gray)),
                  Text(
                    'Gyanpur',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('State:', style: TextStyle(color: AppColors.gray)),
                  Text(
                    'Uttar Pradesh',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Order Details',
                style: TextStyle(color: AppColors.green, fontSize: 16),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rate:', style: TextStyle(color: AppColors.gray)),
                  Text('100', style: TextStyle(color: AppColors.primaryColor)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Mode:',
                    style: TextStyle(color: AppColors.gray),
                  ),
                  Text(
                    'Cash On Delivery',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quantity:', style: TextStyle(color: AppColors.gray)),
                  Text('100', style: TextStyle(color: AppColors.primaryColor)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: TextStyle(color: AppColors.gray),
                  ),
                  Text('150', style: TextStyle(color: AppColors.green)),
                ],
              ),
              SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                  ),
                  onPressed: () {
                    toastification.show(
                      context: context,
                      type: ToastificationType.success,
                      style: ToastificationStyle.minimal,
                      icon: Icon(Icons.check),
                      autoCloseDuration: const Duration(seconds: 1),
                      title: Text('Order Accepted'),
                    );
                  },
                  child: Text('Accept Order'),
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Print Reciept'),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                      ),
                      onPressed: () {},
                      child: Text('Reject Order'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
