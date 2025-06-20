import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: AppTheme.primaryColor,
              size: 35,
            ),
            onPressed: () {
              Get.offAllNamed('/');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.credit_card,
              color: AppTheme.primaryColor,
              size: 35,
            ),
            onPressed: () {
              Get.toNamed('/card');
            },
          ),
          const SizedBox(width: 40), // Space for FAB
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppTheme.primaryColor,
              size: 35,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.message,
              color: AppTheme.primaryColor,
              size: 35,
            ),
            onPressed: () {
              Get.toNamed('/statement');
            },
          ),
        ],
      ),
    );
  }
}
