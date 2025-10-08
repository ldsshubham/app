import 'package:app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderCards extends StatelessWidget {
  final String productName;
  final String price;
  final VoidCallback onAccept;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  const OrderCards({
    super.key,
    required this.productName,
    required this.price,
    required this.onAccept,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.gray.withAlpha(25),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Iconsax.receipt),
                SizedBox(width: 4),
                Text(productName, style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(
              children: [
                Text("₹$price"),
                SizedBox(width: 4),
                IconButton(
                  onPressed: onAccept,
                  icon: Icon(Iconsax.tick_circle, color: AppColors.green),
                ),
                SizedBox(width: 4),

                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Iconsax.trash, color: AppColors.error),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
