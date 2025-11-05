import 'package:flutter/material.dart';
import 'package:shurjopay2/theme/gradient_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          "About",
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
              "About ShurjoPay",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "ShurjoPay is a secure and reliable digital payment solution designed "
              "to make online transactions simple, fast, and safe for individuals "
              "and businesses in Bangladesh. We enable seamless payments for e-commerce, "
              "utility bills, education, and more, empowering users to pay anytime, anywhere.\n\n"
              "Our Vision\n"
              "To become the leading digital payment gateway in Bangladesh, "
              "empowering a cashless and inclusive economy.\n\n"
              "Our Mission\n"
              "• Deliver secure and convenient payment solutions for individuals and enterprises.\n"
              "• Continuously innovate to support evolving digital financial needs.\n"
              "• Contribute to Bangladesh’s digital transformation and financial inclusion.\n\n"
              "Our Features\n"
              "• Multiple Payment Methods: Cards, mobile wallets, internet banking.\n"
              "• Quick & Secure: PCI DSS compliant and encrypted payment process.\n"
              "• Easy Integration: For e-commerce merchants and businesses.\n"
              "• 24/7 Support: Ensuring help is always available when you need it.\n\n"
              "Contact Us: \n\n"
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
