import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_product_model.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/vaccine_request_page.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/vaccine_chip.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/vaccine_info_tile.dart';

class VaccineDetailsPage extends StatelessWidget {
  static Route route(VaccineProduct vaccine) => MaterialPageRoute(builder: (_) => VaccineDetailsPage(vaccine: vaccine));

  final VaccineProduct vaccine;

  const VaccineDetailsPage({super.key, required this.vaccine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Vaccine Details'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            if (vaccine.description != null) ...[
              const SizedBox(height: 6),
              Text(
                vaccine.description ?? '',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
            ],
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (vaccine.gender != null)
                  VaccineChip(
                    label: '${vaccine.gender![0].toUpperCase()}${vaccine.gender!.substring(1)}',
                    icon: HugeIcons.strokeRoundedUser,
                  ),
                if (vaccine.productType != null)
                  VaccineChip(
                    label: '${vaccine.productType![0].toUpperCase()}${vaccine.productType!.substring(1)}',
                    icon: HugeIcons.strokeRoundedDeliveryBox01,
                  ),
              ],
            ),
            VaccineInfoTile(
              title: 'Cost',
              value: '৳ ${vaccine.price}',
              icon: HugeIcons.strokeRoundedWallet01,
            ),
            VaccineInfoTile(
              title: 'Recommended Age',
              value: '${vaccine.from} – ${vaccine.to} years',
              icon: HugeIcons.strokeRoundedCalendar01,
            ),
          ],
        ),
      ),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
