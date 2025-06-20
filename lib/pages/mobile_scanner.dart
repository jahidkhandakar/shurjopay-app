import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileScannerPage extends StatefulWidget {
  @override
  State<MobileScannerPage> createState() => _MobileScannerPageState();
}

class _MobileScannerPageState extends State<MobileScannerPage> {
  late final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) async {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  print("Scanned code: $code"); // Debug log
                  controller.stop();

                  // Check if it's a URL
                  if (code.contains('://')) {
                    final Uri uri = Uri.parse(code);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } else {
                      Get.snackbar("Error", "Could not launch the URL");
                    }
                  } else {
                    // Try to navigate using GetX routes
                    final matchedRoute = Get.routeTree.matchRoute(code).route;
                    if (matchedRoute != null) {
                      Get.offAllNamed(code);
                    } else {
                      Get.snackbar("Error", "Invalid QR code: not a URL or known route");
                    }
                  }
                }
              }
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
