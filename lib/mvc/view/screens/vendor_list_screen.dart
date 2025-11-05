import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/web_handler.dart';
import '../../controller/vendor_controller.dart';
import '../../model/vendor_model.dart';
import '../../../widgets/vendor_tile.dart';

class VendorListScreen extends StatelessWidget {
  final int subCategoryId;

  const VendorListScreen({Key? key, required this.subCategoryId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendors'),
        backgroundColor: const Color(0xFF00C9A7),
        elevation: 4,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        // ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Vendor>>(
        future: VendorController().fetchVendorsBySubCategory(subCategoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final vendors = snapshot.data!;
          return ListView.builder(
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: VendorTile(
                  vendor: vendor,
                  onTap: () {
                    final type = vendor.vendorType?.toLowerCase();
                    final url = vendor.websiteLink;

                    if (type == 'web_view' && url != null && url.isNotEmpty) {
                      WebHandler.open(url);
                    } else {
                      Get.defaultDialog(
                        title: "Oops!",
                        titleStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Service is not available right now. We are working on it.",
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.blueGrey[700],
                                size: 60,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    177,
                                    10,
                                    140,
                                    105,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () => Get.back(),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        radius: 10,
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
