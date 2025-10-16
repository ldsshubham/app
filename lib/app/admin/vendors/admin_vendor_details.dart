// import 'package:app/constants/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class AdminVendorDetails extends StatelessWidget {
//   const AdminVendorDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Vendor Details"), centerTitle: true),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: AppColors.gray,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Vendor Name',
//                 style: TextStyle(
//                   color: AppColors.secondaryColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '100',
//                 style: TextStyle(
//                   color: AppColors.green,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Product Cat',
//                 style: TextStyle(
//                   color: AppColors.secondaryColor.withAlpha(100),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               Text(
//                 'Product Decsriptin',
//                 style: TextStyle(
//                   color: AppColors.gray,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),

//               SizedBox(height: 4),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(50)),
//           color: AppColors.green,
//         ),
//         child: IconButton(
//           onPressed: () {},
//           icon: Icon(Iconsax.edit, color: AppColors.white),
//         ),
//       ),
//     );
//   }
// }
import 'package:app/app/admin/vendors/admin_vendor_controller.dart';
import 'package:app/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminVendorDetails extends StatelessWidget {
  final String vendorId;
  final AdminVendorController controller = Get.find();

  AdminVendorDetails({super.key, required this.vendorId});

  @override
  Widget build(BuildContext context) {
    // Fetch the vendor by ID when this page opens
    controller.getVendorDetailsById(vendorId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Details"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        final v = controller.vendor;

        if (v.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Profile or Banner Image
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.gray.withAlpha(30),
                    borderRadius: BorderRadius.circular(16),
                    image:
                        v['bannerImgUrl'] != null &&
                            v['bannerImgUrl'].toString().isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(v['bannerImgUrl']),
                            fit: BoxFit.cover,
                          )
                        : v['profileImgUrl'] != null &&
                              v['profileImgUrl'].toString().isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(v['profileImgUrl']),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: (v['bannerImgUrl'] == "" && v['profileImgUrl'] == "")
                      ? const Center(child: Icon(Iconsax.image, size: 60))
                      : null,
                ),
                const SizedBox(height: 16),

                Text(
                  v['vendorName'] ?? 'No Name',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  v['businessName'] ?? '',
                  style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  v['address'] ?? '',
                  style: TextStyle(color: AppColors.gray, fontSize: 12),
                ),
                const SizedBox(height: 16),

                Divider(color: AppColors.gray.withAlpha(60)),
                const SizedBox(height: 8),

                _infoTile("Plan", v['plan']),
                _infoTile("Priority Order", v['order'].toString()),
                _infoTile(
                  "Active",
                  v['is_active'] ? "Yes" : "No",
                  color: v['is_active'] ? Colors.green : Colors.red,
                ),
                _infoTile("Pincode", v['pincode']),
                _infoTile("GST / PAN / Aadhaar", v['gst_pan_aadhaar']),
                _infoTile(
                  "Created At",
                  v['createdAt']?.toDate().toString().split('.')[0] ?? '',
                ),
                _infoTile(
                  "Expiry Date",
                  v['expiryDate']?.toDate().toString().split('.')[0] ?? '',
                ),
                const SizedBox(height: 8),

                const Text(
                  "Mobile Numbers",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 4),
                ...(v['mobileNumbers'] as List<dynamic>)
                    .map(
                      (m) =>
                          Text("📞 $m", style: const TextStyle(fontSize: 13)),
                    )
                    .toList(),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          await _updateStatus(true);
                        },
                        icon: const Icon(Iconsax.tick_circle),
                        label: const Text("Approve"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await _updateStatus(false);
                        },
                        icon: const Icon(Iconsax.close_circle),
                        label: const Text("Reject"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.blue,
        ),
        child: IconButton(
          onPressed: () {
            // Later: edit vendor info here
          },
          icon: const Icon(Iconsax.edit, color: Colors.white),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color ?? AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateStatus(bool isActive) async {
    await FirebaseFirestore.instance
        .collection('businesses')
        .doc(vendorId)
        .update({'is_active': isActive});

    Get.snackbar(
      "Status Updated",
      isActive ? "Vendor approved" : "Vendor rejected",
      snackPosition: SnackPosition.BOTTOM,
    );

    await controller.getVendorDetailsById(vendorId); // Refresh data
  }
}
