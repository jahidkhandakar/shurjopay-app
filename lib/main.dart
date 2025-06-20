import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mvc/view/screens/signup_screen.dart';
import 'mvc/view/screens/login_screen.dart';
import 'mvc/view/pages/statement.dart';
import 'web/pranisheba.dart';
import 'mvc/view/pages/reset_pin.dart';
import 'mvc/view/pages/forget_pin.dart';
import 'mvc/view/pages/card_page.dart';
import 'mvc/view/pages/mobile_scanner.dart';
import 'services/mobile_recharge.dart';
import 'services/electricity_bill.dart';
import 'services/water_bill.dart';
import 'services/gas_bill.dart';
import 'services/internet_bill.dart';
import 'services/e_service.dart';
import 'services/shipping.dart';
import 'services/insurance.dart';
import 'services/shopping.dart';
import 'services/health.dart';
import 'services/tickets.dart';
import 'services/travel.dart';
import 'services/courier.dart';
import 'services/store.dart';
import 'services/banking.dart';
import 'mvc/view/screens/otp_screen.dart';
import 'mvc/view/screens/welcome_screen.dart';
import 'mvc/view/screens/home_screen.dart';

void main() {
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
        GetPage(name: '/otp', page: () => OtpScreen(mobileNo: '')),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/card', page: () => CardPage()),
        GetPage(name: '/statement', page: () => StatementPage()),
        GetPage(name: '/forget', page: () => ForgetPin()),
        GetPage(name: '/reset', page: () => ResetPin()),
        GetPage(name: '/scanner', page: () => MobileScannerPage()),
        GetPage(name: '/mobile', page: () => MobileRecharge()),
        GetPage(name: '/electricity', page: () => ElectricityBill()),
        GetPage(name: '/water', page: () => WaterBill()),
        GetPage(name: '/gas', page: () => GasBill()),
        GetPage(name: '/internet', page: () => InternetBill()),
        GetPage(name: '/e-service', page: () => EService()),
        GetPage(name: '/shipping', page: () => Shipping()),
        GetPage(name: '/insurance', page: () => Insurance()),
        GetPage(name: '/shopping', page: () => Shopping()),
        GetPage(name: '/health', page: () => Health()),
        GetPage(name: '/tickets', page: () => Tickets()),
        GetPage(name: '/travel', page: () => Travel()),
        GetPage(name: '/courier', page: () => Courier()),
        GetPage(name: '/store', page: () => Store()),
        GetPage(name: '/banking', page: () => Banking()),
        GetPage(name: '/pranisheba', page: () => Pranisheba()),
        GetPage(name: '/', page: () => WelcomeScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
