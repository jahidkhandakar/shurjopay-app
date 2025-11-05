import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shurjopay2/mvc/controller/profile_controller.dart';
import 'package:shurjopay2/mvc/view/pages/about_page.dart';
import 'package:shurjopay2/mvc/view/pages/notification_page.dart';
import 'package:shurjopay2/mvc/view/pages/privacy_policy_page.dart';
import 'package:shurjopay2/mvc/view/pages/profile_page.dart';
import 'package:shurjopay2/mvc/view/pages/settings_page.dart';
import 'package:shurjopay2/mvc/view/pages/terms_conditions_page.dart';
import 'package:shurjopay2/mvc/view/screens/in_app_payment_screen.dart';
import 'package:shurjopay2/mvc/view/screens/vendor_screen_wrapper.dart';
import 'mvc/view/screens/signup_screen.dart';
import 'mvc/view/screens/login_screen.dart';
import 'mvc/view/pages/transaction_page.dart';
import 'web/pranisheba.dart';
import 'mvc/view/screens/reset_pin_screen.dart';
import 'mvc/view/screens/pin_recovery_screen.dart';
import 'mvc/view/pages/card_page.dart';
import 'mvc/view/pages/mobile_scanner_page.dart';
import 'mvc/view/screens/otp_screen.dart';
import 'mvc/view/screens/welcome_screen.dart';
import 'mvc/view/screens/service_category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ProfileController(), permanent: true); 
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ShurjoPay',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/otp', page: () => OtpScreen()),
        GetPage(name: '/card', page: () => CardPage()),
        GetPage(name: '/transaction', page: () => TransactionPage()),
        GetPage(name: '/recovery', page: () => PinRecoveryScreen()),
        GetPage(name: '/reset', page: () => ResetPinScreen()),
        GetPage(name: '/scanner', page: () => MobileScannerPage()),
        GetPage(name: '/pranisheba', page: () => Pranisheba()),
        GetPage(name: '/', page: () => WelcomeScreen()),
        GetPage(name: '/services', page: () => ServiceCategoryScreen()),
        GetPage(name: '/vendors', page: () => VendorScreenWrapper()),
        GetPage(name: '/in_app_payment', page: () => InAppPaymentScreen()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/privacy', page: () => PrivacyPolicyPage()),
        GetPage(name: '/terms', page: () => TermsConditionsPage()),
        GetPage(name: '/about', page: () => AboutPage()),
        GetPage(name: '/notification', page: () => NotificationPage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
