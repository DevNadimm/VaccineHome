import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_recommendations_model.dart';

class VaccineRecommendationDetailsPage extends StatelessWidget {
  static Route route({required VaccineRecommendation recommendation}) => MaterialPageRoute(builder: (_) => VaccineRecommendationDetailsPage(recommendation: recommendation));

  final VaccineRecommendation recommendation;

  const VaccineRecommendationDetailsPage({
    super.key,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    final product = recommendation.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Details'),
        leading: const AppBarBackBtn(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (product?.image != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CustomCachedImage(
                    imageUrl: product!.image ?? '',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product?.name != null) ...[
                    Text(
                      product!.name!,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  if (product?.price != null)
                    Text(
                      '${product!.price} Tk',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                  if (recommendation.reason != null) ...[
                    Text(
                      'Why this vaccine?',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryFontColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: AppColors.inputBorderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Text(
                        recommendation.reason!,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                  if (recommendation.details != null) ...[
                    Text(
                      'Details',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryFontColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recommendation.details!,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                  if (product != null) ...[
                    Text(
                      'About this vaccine',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryFontColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (product.description != null)
                      _buildInfoItem('Description', product.description!),
                    if (product.from != null || product.to != null)
                      _buildInfoItem('Age Range', '${product.from ?? 'Birth'} - ${product.to ?? 'Adult'}'),
                    if (product.gender != null)
                      _buildInfoItem('For', product.gender!),
                    if (product.productType != null)
                      _buildInfoItem('Type', product.productType!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? "${value[0].toUpperCase()}${value.substring(1)}" : "—",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}