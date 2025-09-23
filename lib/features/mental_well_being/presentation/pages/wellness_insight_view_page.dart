import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/helper_functions/date_conversion_helper.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/mental_well_being/data/models/mental_well_being_model.dart';

class WellnessInsightViewPage extends StatelessWidget {
  static Route route(MentalWellBeingItem insight) => MaterialPageRoute(builder: (_) => WellnessInsightViewPage(insight: insight));

  final MentalWellBeingItem insight;

  const WellnessInsightViewPage({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackBtn(),
        title: const Text('Wellness Insight'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomCachedImage(
                  imageUrl: insight.image ?? '',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                insight.title ?? 'Unknown Title',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (insight.createdAt != null) ...[
                Text(
                  DateConversionHelper.fromCustomFormat(insight.createdAt!),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryFontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              if (insight.description != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    insight.description!,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryFontColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
