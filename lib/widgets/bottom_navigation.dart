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
          // 🟢 Gradient Home Icon
          IconButton(
            icon: ShaderMask(
              shaderCallback:
                  (bounds) => AppTheme.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: const Icon(Icons.home, size: 40, color: Colors.white),
            ),
            onPressed: () {
              Get.offAllNamed('/services');
            },
          ),

          // 🟢 Gradient Card Icon
          IconButton(
            icon: ShaderMask(
              shaderCallback:
                  (bounds) => AppTheme.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: const Icon(
                Icons.credit_card,
                size: 40,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Get.toNamed('/card');
            },
          ),
          //Gradient Search Icon
          IconButton(
            icon: ShaderMask(
              shaderCallback:
                  (bounds) => AppTheme.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: const Icon(Icons.search, color: Colors.white, size: 40),
            ),
            onPressed: () {
              Get.snackbar(
                'Service Not Available',
                'This feature is coming soon.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              );
            },
          ),
          // Gradient Statement Icon
          IconButton(
            icon: ShaderMask(
              shaderCallback:
                  (bounds) => AppTheme.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: const Icon(Icons.message, color: Colors.white, size: 40),
            ),
            onPressed: () {
              Get.toNamed('/transaction');
            },
          ),
        ],
      ),
    );
  }
}
