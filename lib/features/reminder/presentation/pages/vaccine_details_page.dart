import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_product_model.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/vaccine_request_page.dart';

class VaccineDetailsPage extends StatelessWidget {
  static Route route(VaccineProduct vaccine) => MaterialPageRoute(builder: (_) => VaccineDetailsPage(vaccine: vaccine));

  final VaccineProduct vaccine;

  const VaccineDetailsPage({super.key, required this.vaccine});

  Widget _buildChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryFontColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryFontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Vaccine Details',
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),

      /// Floating bottom button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, VaccineRequestPage.route(vaccine.id ?? 0));
              },
              child: const Text(
                "Request This Vaccine",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Vaccine Image
            if (vaccine.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CustomCachedImage(
                  imageUrl: vaccine.image ?? '',
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),

            /// Title
            Text(
              vaccine.name ?? "Unnamed Vaccine",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryFontColor,
                ),
              ),
            ),
            const SizedBox(height: 6),

            /// Description
            if (vaccine.description != null)
              Text(
                vaccine.description!,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (vaccine.gender != null)
                  _buildChip(
                    '${vaccine.gender![0].toUpperCase()}${vaccine.gender!.substring(1)}',
                    HugeIcons.strokeRoundedUser,
                  ),
                if (vaccine.productType != null)
                  _buildChip(
                    '${vaccine.productType![0].toUpperCase()}${vaccine.productType!.substring(1)}',
                    HugeIcons.strokeRoundedDeliveryBox01,
                  ),
              ],
            ),
            _buildInfo('Cost', '৳ ${vaccine.price}', HugeIcons.strokeRoundedWallet01),
            _buildInfo('Recommended Age', '${vaccine.from} – ${vaccine.to} years', HugeIcons.strokeRoundedCalendar01),
          ],
        ),
      ),
    );
  }
}
