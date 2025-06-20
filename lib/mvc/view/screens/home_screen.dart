import 'package:flutter/material.dart';
import '../pages/ad_banner.dart';
import '../../../widgets/service_category_tile.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/user_profile_drawer.dart';
import '../../../widgets/bottom_navigation.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShurjoPay',
          style: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.green,
                  size: 35,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.green, size: 35),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
          ),
        ],
      ),
      drawer: const UserProfileDrawer(),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceCategoryTile(
              title: 'Recharge & Bill Payments',
              services: [
                {
                  'icon': Icons.phone_android,
                  'label': 'Mobile\nRecharge',
                  'onTap': () => Get.toNamed('/mobile'),
                },
                {
                  'icon': Icons.bolt,
                  'label': 'Electricity\nBill',
                  'onTap': () => Get.toNamed('/electricity'),
                },
                {
                  'icon': Icons.water_drop,
                  'label': 'Water\nBill',
                  'onTap': () => Get.toNamed('/water'),
                },
                {
                  'icon': Icons.gas_meter,
                  'label': 'Gas\nBill',
                  'onTap': () => Get.toNamed('/gas'),
                },
                {
                  'icon': Icons.wifi,
                  'label': 'Internet\nBill',
                  'onTap': () => Get.toNamed('/internet'),
                },
                {
                  'icon': Icons.computer,
                  'label': 'E-Service',
                  'onTap': () => Get.toNamed('/e-service'),
                },
              ],
            ),
            const SizedBox(height: 20),
            const AdBanner(),
            const SizedBox(height: 20),
            ServiceCategoryTile(
              title: 'Banking & Insurance',
              services: [
                {
                  'icon': Icons.account_balance,
                  'label': 'Banking',
                  'onTap': () => Get.toNamed('/banking'),
                },
                { 'icon': Icons.security, 
                  'label': 'Insurance', 
                  'onTap': () => Get.toNamed('/insurance'),
                },
              ],
            ),
            ServiceCategoryTile(
              title: 'Food, Health & Lifestyle',
              services: [
                {
                  'icon': Icons.shopping_cart,
                  'label': 'Shopping',
                  'onTap': () => Get.toNamed('/shopping'),
                },
                {
                  'icon': Icons.health_and_safety,
                  'label': 'Health',
                  'onTap': () => Get.toNamed('/health'),
                },
              ],
            ),
            ServiceCategoryTile(
              title: 'Tours & Travel',
              services: [
                {
                  'icon': Icons.airplane_ticket,
                  'label': 'Tickets',
                  'onTap': () => Get.toNamed('/tickets'),
                },
                { 
                  'icon': Icons.flight, 
                  'label': 'Travel', 
                  'onTap': () => Get.toNamed('/travel'),
                },
              ],
            ),
            ServiceCategoryTile(
              title: 'Other Services',
              services: [
                {
                  'icon': Icons.delivery_dining,
                  'label': 'Courier',
                  'onTap': () => Get.toNamed('/courier'),
                },
                { 
                  'icon': Icons.store, 
                  'label': 'Store', 
                  'onTap': () => Get.toNamed('/store'),
                },
                {
                  'icon': Icons.local_shipping,
                  'label': 'Shipping',
                  'onTap': () => Get.toNamed('/shipping'),
                },
              ],
            ),
          ],
        ),
      ),
      //*_______________________QR Code Scanner_________________________
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed('/scanner');
          if (result != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Scanned: $result")));
          }
        },
        backgroundColor: Colors.green[300],
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //*_______________________Bottom Navigation Bar_________________________
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
