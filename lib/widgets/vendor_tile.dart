import 'package:flutter/material.dart';
import '../mvc/model/vendor_model.dart';

class VendorTile extends StatelessWidget {
  final Vendor vendor;
  final VoidCallback? onTap;

  const VendorTile({
    Key? key,
    required this.vendor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasLogo = vendor.logo != null && vendor.logo!.isNotEmpty;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: hasLogo
              ? Image.network(
                  vendor.logo!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    "assets/images/default_vendor.png",
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  "assets/images/default_vendor.png",
                  fit: BoxFit.cover,
                ),
        ),
      ),
      title: Text(
        vendor.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
      subtitle: const Text(
        "Tap to continue",
        style: TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.teal),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: Colors.greenAccent.withOpacity(0.1),
      onTap: onTap,
    );
  }
}
