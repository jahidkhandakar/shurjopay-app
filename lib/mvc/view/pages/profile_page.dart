import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme/gradient_text.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/icon_theme.dart';
import '../../../widgets/custom_button_primary.dart';
import '../../controller/profile_controller.dart';
import '../../model/profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _controller = Get.find<ProfileController>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController(); // read-only

  File? _selectedImage;
  bool _isChanged = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // If profile already loaded before this page is opened
    final existingProfile = _controller.profile.value;
    if (existingProfile != null) {
      _populateFields(existingProfile);
    }

    // Whenever profile updates (after save or API call), update fields
    ever<Profile?>(_controller.profile, (profile) {
      if (profile != null) {
        _populateFields(profile);
      }
    });
  }

  void _populateFields(Profile profile) {
    _nameController.text = profile.name;
    _emailController.text = profile.email;
    _dobController.text = profile.dateOfBirth;
    _phoneController.text = profile.mobileNo;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _isChanged = true;
      });
      Get.snackbar(
        "Image Selected",
        "Profile image updated temporarily",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _pickDate() async {
    DateTime initialDate =
        DateTime.tryParse(_dobController.text) ?? DateTime(2000);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppTheme.primaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _dobController.text = picked.toIso8601String().split("T").first;
      setState(() => _isChanged = true);
    }
  }

  bool _isValidEmail(String email) => GetUtils.isEmail(email);

  Future<void> _submitChanges() async {
    if (!_formKey.currentState!.validate()) return;

    await _controller.updateProfileData(
      name: _nameController.text,
      email: _emailController.text,
      dateOfBirth: _dobController.text,
    );

    if (_selectedImage != null) {
      await _controller.updateProfileImage(_selectedImage!);
    }

    Get.snackbar(
      "Success",
      "Profile updated successfully",
      backgroundColor: Colors.green.withOpacity(0.7),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    setState(() => _isChanged = false);
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      onChanged: (_) => setState(() => _isChanged = true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: GradientIcon(icon: icon, size: 22),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 16, color: Colors.black87),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final profile = _controller.profile.value;
          if (profile == null) {
            return const Center(
              child: Text(
                "No profile data found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 32.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: AppTheme.primaryColor,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.white,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (profile.profileImage.isNotEmpty
                                  ? NetworkImage(profile.profileImage)
                                  : const AssetImage(
                                      'assets/images/avatar_placeholder.png',
                                    )) as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      color: Colors.white.withOpacity(0.97),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 28,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GradientText(
                              "Profile Information",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            _buildField(
                              controller: _nameController,
                              label: "Name",
                              icon: Icons.person,
                              validator: (val) => val == null || val.trim().isEmpty
                                  ? "Name cannot be empty"
                                  : null,
                            ),
                            const SizedBox(height: 18),
                            _buildField(
                              controller: _emailController,
                              label: "Email",
                              icon: Icons.email,
                              validator: (val) => val == null ||
                                      val.isEmpty ||
                                      !_isValidEmail(val)
                                  ? "Enter a valid email"
                                  : null,
                            ),
                            const SizedBox(height: 18),
                            _buildField(
                              controller: _dobController,
                              label: "Date of Birth",
                              icon: Icons.cake,
                              onTap: _pickDate,
                              validator: (val) => val == null || val.isEmpty
                                  ? "Select date of birth"
                                  : null,
                            ),
                            const SizedBox(height: 18),
                            _buildField(
                              controller: _phoneController,
                              label: "Mobile Number",
                              icon: Icons.phone,
                              readOnly: true,
                            ),
                            const SizedBox(height: 30),
                            CustomButtonPrimary(
                              text: "Save Changes",
                              onPressed: _isChanged ? _submitChanges : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
