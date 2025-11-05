import 'package:flutter/material.dart';
import 'package:shurjopay2/theme/gradient_text.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          "Privacy Policy",
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Effective Date: 28 July 2025\n\n"
              "At ShurjoPay, we value your trust and take your privacy seriously. "
              "This Privacy Policy explains how we collect, use, disclose, and protect your personal "
              "information when you use the ShurjoPay mobile application (“App”) and related services.\n\n"
              "1. Information We Collect\n"
              "• Personal Information: Name, phone number, email address, date of birth, and national identification details (if required).\n"
              "• Payment Information: Bank account details, card information, and transaction history.\n"
              "• Profile & Account Data: Profile image, preferences, and app settings.\n\n"
              "2. Information We Collect Automatically\n"
              "• Device Information: Device model, operating system, unique identifiers, and mobile network information.\n"
              "• App Usage Data: Interactions, session duration, error logs, and feature usage analytics.\n"
              "• Location Data: With your permission, we may collect location information to enable location-based features and prevent fraud.\n\n"
              "3. How We Use Your Information\n"
              "• To create and manage your account.\n"
              "• To process payments and complete transactions securely.\n"
              "• To enhance app performance, personalize user experience, and improve our services.\n"
              "• To comply with legal obligations including KYC and AML requirements.\n"
              "• To communicate updates, send transaction alerts, and resolve support queries.\n"
              "• To detect, prevent, and address fraudulent or illegal activity.\n\n"
              "4. How We Share Your Information\n"
              "We may share your data with financial institutions, regulatory authorities, and third-party service providers for analytics, "
              "cloud storage, customer support, and security. We do not sell your personal information.\n\n"
              "5. Data Retention\n"
              "We retain your information only as long as necessary to fulfill the purposes outlined in this policy and comply with legal obligations.\n\n"
              "6. Your Rights\n"
              "You have the right to access, update, or delete your personal information, subject to regulatory requirements. "
              "For requests, contact support@shurjopay.com.bd.\n\n"
              "7. Data Security\n"
              "We implement industry-standard security measures including encryption, secure servers, and restricted access "
              "to protect your data.\n\n"
              "8. Cookies & Tracking Technologies\n"
              "We may use cookies and similar technologies to improve user experience, collect analytics data, and remember your preferences.\n\n"
              "9. Third-Party Links\n"
              "The app may contain links to third-party websites or services. We are not responsible for their privacy practices.\n\n"
              "10. Children’s Privacy\n"
              "We do not knowingly collect data from individuals under 18 years of age.\n\n"
              "11. Updates to This Policy\n"
              "We may update this Privacy Policy from time to time. Please review regularly for changes.\n\n"
              "12. Contact Us: \n\n"
              "Email: info@shurjopay.com.bd\n"
              "Phone: +8809643207001\n",
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "© 2025 ShurjoPay",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
