import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final double offsetY;
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomFloatingActionButton({
    super.key,
    this.offsetY = -20,
    this.icon = Icons.qr_code_scanner,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: onPressed ??
              () async {
                final result = await Get.toNamed('/scanner');
                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Scanned: $result")),
                  );
                }
              },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
