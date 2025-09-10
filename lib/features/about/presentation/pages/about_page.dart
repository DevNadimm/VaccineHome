import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/features/about/presentation/widgets/branding_section.dart';

class AboutPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const AboutPage());

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String aboutUsDescription = "Welcome to Vaccine Home,\n\nAt Vaccine Home, we believe healthcare should be simple, accessible, and reliable. Our mission is to provide a trusted digital health companion that helps individuals and families stay on top of their vaccination schedules and overall well-being.\n\nWe know that keeping track of vaccines and health reminders can be challenging. That’s why we created a platform to manage everything in one place — from timely notifications to secure health records.\n\nOur team is dedicated to combining technology with healthcare innovation. We aim to deliver accurate information, personalized reminders, and easy-to-use features that fit into your daily routine.\n\nWith Vaccine Home, you are not just staying updated with vaccines — you are building a healthier and safer future for yourself and your loved ones.\n\nThank you for trusting Vaccine Home as your digital health companion.";

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const BrandingSection(),
              const SizedBox(height: 24),
              Text(
                aboutUsDescription,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryFontColor,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
