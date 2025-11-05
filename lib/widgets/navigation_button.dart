import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

class NavigationButton extends StatelessWidget {
  final String frontNavigation;
  final String backNavigation;

  const NavigationButton({
    super.key, 
    required this.frontNavigation, 
    required this.backNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
            onPressed: () {
              Get.offAllNamed(backNavigation); // Navigate back
            },
            child: const Icon(Icons.arrow_back),
            backgroundColor: AppTheme.primaryColor,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            Get.toNamed(frontNavigation); // Navigate to front page
          },
          child: const Icon(Icons.forward),
          backgroundColor: AppTheme.primaryColor,
        ),
      ],
    );
  }
}
