import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vendor_list_screen.dart';

class VendorScreenWrapper extends StatelessWidget {
  const VendorScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final int subCategoryId = Get.arguments;
    return VendorListScreen(subCategoryId: subCategoryId);
  }
}
