import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shurjopay2/theme/icon_theme.dart';
import '../../controller/service_controller.dart';
import '../../model/service_category_model.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/user_profile_drawer.dart';
import '../../../widgets/bottom_navigation.dart';
import 'vendor_list_screen.dart';
import '../../../theme/gradient_text.dart';
import '../../../widgets/custom_floating_action_button.dart';
import '../../../utils/icon_mapper.dart';
import '../../../widgets/banner_slider.dart';

class ServiceCategoryScreen extends StatefulWidget {
  const ServiceCategoryScreen({super.key});

  @override
  State<ServiceCategoryScreen> createState() => _ServiceCategoryScreenState();
}

class _ServiceCategoryScreenState extends State<ServiceCategoryScreen> {
  late Future<List<ServiceCategory>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    final token = GetStorage().read('token');
    _categoriesFuture = _loadCategories(token);
  }

  Future<List<ServiceCategory>> _loadCategories(String token) async {
    return await ServiceController().fetchServiceCategoriesWithSubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          'SERVICES',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: GradientIcon(
                  icon: Icons.account_circle,
                  size: 35,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: GradientIcon(
                    icon: Icons.menu,
                    size: 35,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      //*___________________Main Drawer and End Drawer_____________________
      drawer: const UserProfileDrawer(),
      endDrawer: const CustomDrawer(),
      //*__________________________________________________________________
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Expanded for the service categories
          Expanded(
            child: FutureBuilder<List<ServiceCategory>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: {snapshot.error}'));
                }

                final categories = snapshot.data!;
                List<Widget> categoryWidgets = [];

                for (int i = 0; i < categories.length; i++) {
                  final category = categories[i];

                  //*_________________________________________
                  //? Add the BannerSlider AFTER the first category
                  if (i == 1) {
                    categoryWidgets.add(
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 1,
                          left: 0,
                          right: 0,
                          bottom: 6,
                        ),
                        child: BannerSlider(),
                      ),
                    );
                  }
                  //*_________________________________________

                  categoryWidgets.add(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.85,
                              ),
                          itemCount: category.subCategories.length,
                          itemBuilder: (context, subIndex) {
                            final sub = category.subCategories[subIndex];
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => VendorListScreen(subCategoryId: sub.id),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GradientIcon(
                                      icon: getIconFromString(sub.icon),
                                      size: 36,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      sub.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: categoryWidgets,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
