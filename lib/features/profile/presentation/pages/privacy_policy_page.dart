import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());

  const PrivacyPolicyPage({super.key});

  final String privacyPolicyText = """
**Privacy Policy for Vaccine Home**

Your privacy is important to us. Vaccine Home collects minimal personal information to provide you with a safe and personalized healthcare experience.

**Information We Collect:**
- Personal information such as name, email, phone number, and date of birth.
- Health-related information such as vaccination records.
- Usage data to improve app functionality.
- Device information and app usage analytics.

**How We Use Your Information:**
- To provide notifications and reminders for vaccinations.
- To store and secure your health information.
- To improve the app experience and deliver personalized content.
- To communicate important updates and announcements.

**Cookies and Tracking:**
- Vaccine Home does not use cookies in the app, but we may use analytics tools to understand app usage. 
- All analytics are anonymized and do not include personal information.

**Data Security:**
We implement strict security measures to protect your information. Your data is encrypted and stored securely. Only authorized personnel have access to your health information.

**Sharing Information:**
- We do not sell your data. 
- Information may be shared with trusted healthcare partners only to provide services you requested.
- We may disclose data if required by law or to protect public health.

**User Rights:**
- You can request access to your personal data stored in the app.
- You can request correction or deletion of your data by contacting support.
- You can opt out of notifications or certain app features at any time.

**Data Retention:**
We retain your personal and health data only as long as necessary to provide services or comply with legal obligations. Old or inactive data is securely deleted.

**Changes to Privacy Policy:**
Any changes will be posted on this page. Please review periodically.

**Contact Us:**
For questions regarding privacy, data requests, or complaints, contact us at support@vaccinehome.com.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
          data: privacyPolicyText,
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
