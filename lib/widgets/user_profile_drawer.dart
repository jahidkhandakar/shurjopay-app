import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shurjopay2/theme/icon_theme.dart';
import 'package:shurjopay2/widgets/logout_tile.dart';
import '../theme/app_theme.dart';
import '../mvc/controller/profile_controller.dart';

class UserProfileDrawer extends StatelessWidget {
  const UserProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Drawer(
      child: Column(
        children: [
          // ======= Custom Drawer Header (No Overflow) =======
          Obx(() {
            final profile = profileController.profile.value;
            final isLoading = profileController.isLoading.value;

            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          (profile?.profileImage != null &&
                                  profile!.profileImage!.isNotEmpty)
                              ? NetworkImage(profile.profileImage!)
                              : null,
                      child:
                          (profile?.profileImage == null ||
                                  profile!.profileImage!.isEmpty)
                              ? ShaderMask(
                                shaderCallback:
                                    (bounds) =>
                                        AppTheme.primaryGradient.createShader(
                                          Rect.fromLTWH(
                                            0,
                                            0,
                                            bounds.width,
                                            bounds.height,
                                          ),
                                        ),
                                child: const Icon(
                                  Icons.account_circle,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              )
                              : null,
                    ),
                    const SizedBox(height: 6),
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    else ...[
                      FittedBox(
                        child: Text(
                          profile?.name ?? "Unknown User",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        child: Text(
                          profile?.email ?? "No email",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),

          // ======= Drawer Items =======
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.person_outline,
                  title: "Profile",
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/profile');
                  },
                ),
                const SizedBox(height: 8.0),
                _buildDrawerItem(
                  icon: Icons.history,
                  title: "Transaction History",
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/transaction');
                  },
                ),
                const SizedBox(height: 8.0),
                _buildDrawerItem(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/notification');
                  },
                ),
                const SizedBox(height: 8.0),
                _buildDrawerItem(
                  icon: Icons.info_outline,
                  title: "About",
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/about');
                  },
                ),
              ],
            ),
          ),

          // *============== Logout Button =================
          const LogoutTile(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: GradientIcon(icon: icon, size: 35),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
