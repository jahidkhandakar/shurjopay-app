import 'package:flutter/material.dart';
import 'package:shurjopay2/theme/gradient_text.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          "Terms & Conditions",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              "ShurjoPay App Terms & Conditions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Effective Date: 28 July 2025\n\n"
              "1. Acceptance of Terms\n"
              "By downloading, installing, and using the ShurjoPay App, you agree to comply with and be legally bound by these Terms & Conditions. "
              "If you do not agree, please uninstall the app and discontinue its use.\n\n"
              "2. Eligibility\n"
              "You must be at least 18 years old and legally capable of entering into binding contracts to use ShurjoPay.\n\n"
              "3. User Responsibilities\n"
              "• Provide accurate information during account registration and keep it updated.\n"
              "• Maintain the confidentiality of your account credentials.\n"
              "• Immediately notify ShurjoPay if you suspect unauthorized use of your account.\n\n"
              "4. Payment Services\n"
              "• ShurjoPay facilitates digital transactions through authorized payment gateways and banking channels.\n"
              "• All transactions are final and non-refundable unless required by law or determined by ShurjoPay policy.\n"
              "• Transaction processing time and fees may vary based on the financial institutions involved.\n\n"
              "5. Prohibited Activities\n"
              "You agree not to:\n"
              "• Use the app for fraudulent, illegal, or unauthorized purposes.\n"
              "• Interfere with or disrupt the app’s security, servers, or networks.\n"
              "• Copy, modify, or reverse-engineer any part of the app without prior written consent.\n\n"
              "6. Intellectual Property\n"
              "All content, trademarks, logos, and code related to ShurjoPay are the property of ShurjoPay Limited. "
              "Unauthorized use is strictly prohibited.\n\n"
              "7. Limitation of Liability\n"
              "ShurjoPay is not liable for:\n"
              "• Losses due to incorrect payment details provided by you.\n"
              "• Network or technical failures beyond ShurjoPay’s control.\n"
              "• Unauthorized access to your account due to your negligence.\n\n"
              "8. Changes to Terms\n"
              "ShurjoPay may update these Terms at any time. Continued use of the app after updates constitutes acceptance of the new terms.\n\n"
              "9. Termination\n"
              "ShurjoPay reserves the right to suspend or terminate your account if you violate these terms or engage in fraudulent/illegal activities.\n\n"
              "10. Governing Law\n"
              "These Terms are governed by the laws of Bangladesh. Disputes shall be resolved exclusively in the courts of Dhaka.\n\n"
              "11. Contact Us: \n\n"
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
