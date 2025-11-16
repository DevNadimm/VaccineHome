import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/features/about/presentation/widgets/branding_section.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hugeicons/hugeicons.dart';

class ContactUsPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const ContactUsPage());

  const ContactUsPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandingSection(),
              const SizedBox(height: 24),

              // Welcome Message
              Text(
                'Thank you for contacting Vaccine Home! Let us know how we can assist you.',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryFontColor,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),

              // Phone Numbers Section
              _buildContactCard(
                icon: HugeIcons.strokeRoundedCall02,
                title: 'Phone Numbers',
                children: [
                  _buildClickableItem(
                    text: '01819102021',
                    onTap: () => _launchUrl('tel:01819102021'),
                  ),
                  const SizedBox(height: 8),
                  _buildClickableItem(
                    text: '01734941989',
                    onTap: () => _launchUrl('tel:01734941989'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Location Section
              _buildContactCard(
                icon: HugeIcons.strokeRoundedLocation06,
                title: 'Our Address',
                children: [
                  Text(
                    'Beside Epic Health Care,\nCare Investigation Building, 3rd Floor.',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryFontColor,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    label: 'View on Map',
                    icon: HugeIcons.strokeRoundedMapsLocation01,
                    onTap: () => _launchUrl('https://maps.app.goo.gl/8G4WzEx1TaQB8D769'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Business Hours Section
              _buildContactCard(
                icon: HugeIcons.strokeRoundedTime03,
                title: 'Business Hours',
                children: [
                  _buildBusinessHoursRow(
                    day: 'Saturday - Thursday',
                    time: '10:00 AM - 9:00 PM',
                  ),
                  const SizedBox(height: 8),
                  _buildBusinessHoursRow(
                    day: 'Friday',
                    time: '10:00 AM - 7:00 PM',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Social Links Section
              _buildContactCard(
                icon: HugeIcons.strokeRoundedLink02,
                title: 'Social Media',
                children: [
                  Text(
                    'Stay connected with us on all social media platforms.',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    label: 'Social Media Links',
                    icon: HugeIcons.strokeRoundedLinkSquare02,
                    onTap: () => _launchUrl('https://linktr.ee/vaccinehome'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildClickableItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Icon(
              HugeIcons.strokeRoundedCall02,
              size: 18,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessHoursRow({
    required String day,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            day,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            time,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.secondaryFontColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
