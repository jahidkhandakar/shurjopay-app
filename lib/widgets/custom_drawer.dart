import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shurjopay2/theme/icon_theme.dart';
import '../theme/app_theme.dart';
import 'package:share_plus/share_plus.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 27),
                Center(
                  child: Text(
                    'shurjoPay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: GradientIcon(icon: Icons.home, size: 35),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/services');
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const GradientIcon(icon: Icons.settings, size: 35),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/settings');
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const GradientIcon(icon: Icons.person_add, size: 35),
            title: const Text('Refer a friend'),
            onTap: () {
              const referralCode =
                  "USER123"; // Replace with actual user ID or code
              final referralLink =
                  "https://shurjopay.com/signup?ref=$referralCode";
              Share.share(
                "Join ShurjoPay and enjoy seamless payments! Sign up using my link: $referralLink",
                subject: "ShurjoPay Referral",
              );
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const GradientIcon(
              icon: Icons.description_outlined,
              size: 35,
            ),
            title: const Text('Terms & Conditions'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/terms');
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const GradientIcon(icon: Icons.privacy_tip, size: 35),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/privacy');
            },
          ),
          const SizedBox(height: 8),

          // Help & Support as ExpansionTile
          ExpansionTile(
            leading: const GradientIcon(icon: Icons.support_agent, size: 35),
            title: const Text('Help & Support'),
            children: const [
              ListTile(
                leading: Icon(Icons.email, color: AppTheme.secondaryColor),
                title: Text('info@shurjopay.com.bd'),
              ),
              ListTile(
                leading: Icon(Icons.phone, color: AppTheme.primaryColor),
                title: Text('+8809643207001'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
