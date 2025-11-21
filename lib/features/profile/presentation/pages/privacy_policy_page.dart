import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());

  const PrivacyPolicyPage({super.key});

  final String privacyPolicyText = """
**Privacy Policy for Vaccine Sheba**

Your privacy is important to us. Vaccine Sheba collects minimal personal information to provide you with a safe and personalized healthcare experience.

**Information We Collect:**
- Personal info: name, email, phone number, date of birth.
- Health info: vaccination records and health status.
- Order info: vaccine orders (cash payment only) and card requests.
- Usage data: app functionality and wellness content analytics.
- Device info and app usage analytics.

**How We Use Your Information:**
- Provide notifications and reminders for self-care and vaccinations.
- Process vaccine orders and manage Vaccine Card requests.
- Improve app experience and deliver personalized content.
- Communicate important updates and announcements.

**Cookies and Tracking:**
- We do not use cookies but may use anonymized analytics tools to understand app usage.

**Data Security:**
Your data is encrypted and securely stored. Only authorized personnel can access your health information.

**Sharing Information:**
- We do not sell your data.
- Info may be shared with trusted healthcare partners to provide requested services.
- We may disclose data if required by law or to protect public health.

**User Rights:**
- Access, correct, or request deletion of your personal and health data.
- Opt-out of notifications or certain app features at any time.

**Data Retention:**
Data is retained only as long as necessary to provide services or comply with legal obligations. Old/inactive data is securely deleted.

**Changes to Privacy Policy:**
Any changes will be posted here. Review periodically.

**Contact Us:**
For privacy questions or data requests, contact support@vaccinehomebd.com.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: const AppBarBackBtn(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
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
