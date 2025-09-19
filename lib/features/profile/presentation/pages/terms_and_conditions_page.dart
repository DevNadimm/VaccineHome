import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const TermsAndConditionsPage());

  const TermsAndConditionsPage({super.key});

  final String termsText = """
**Terms and Conditions for Vaccine Home**

Welcome to Vaccine Home! By using our app, you agree to the following terms and conditions:

**1. Use of App:**
- Vaccine Home is intended to provide vaccination reminders, health information, and management of personal health records.
- You must use the app for lawful purposes only.

**2. User Accounts:**
- Some features require creating an account and providing accurate personal information.
- You are responsible for maintaining the confidentiality of your account login.

**3. Health Information Disclaimer:**
- Vaccine Home provides reminders and information; it is not a substitute for professional medical advice.
- Always consult healthcare professionals for medical decisions.

**4. Intellectual Property:**
- All content, design, and branding of Vaccine Home are the property of the app developers.
- You may not reproduce, distribute, or modify any part of the app without permission.

**5. Third-Party Services:**
- Vaccine Home may integrate with third-party services (e.g., notifications, analytics).
- Use of these services is subject to their respective terms.

**6. Limitation of Liability:**
- Vaccine Home is not liable for any direct or indirect damages arising from the use of the app.
- Users assume full responsibility for following vaccination schedules and health advice.

**7. Changes to Terms:**
- We may update these terms periodically. Users will be notified within the app.
- Continued use of the app after updates constitutes acceptance of new terms.

**8. Contact Us:**
- For questions or concerns regarding Terms & Conditions, contact us at support@vaccinehome.com.

By using Vaccine Home, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Markdown(
          data: termsText,
          styleSheet: MarkdownStyleSheet(
            p: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryFontColor,
              height: 1.5,
            ),
            h2: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryFontColor,
            ),
            listBullet: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryFontColor,
            ),
          ),
        ),
      ),
    );
  }
}
