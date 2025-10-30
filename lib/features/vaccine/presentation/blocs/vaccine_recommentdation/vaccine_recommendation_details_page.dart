import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_recommendations_model.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/image_selection_cubit.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/full_screen_image_page.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/image_selection_card.dart';

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
        leading: AppBarBackBtn(
          onBack: () {
            context.read<ImageSelectionCubit>().reset();
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (recommendation.product!.images != null && recommendation.product!.images!.isNotEmpty)
              ...[
                BlocBuilder<ImageSelectionCubit, int>(
                  builder: (context, state) {
                    final images = recommendation.product!.images ?? [];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(context, FullScreenImagePage.route(imageUrl: images[state])),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Stack(
                                  children: [
                                    CustomCachedImage(
                                      imageUrl: images[state],
                                      height: 260,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.black.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              HugeIcons.strokeRoundedZoomInArea,
                                              size: 16,
                                              color: AppColors.white,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Tap to enlarge',
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(images.length, (index) {
                              return GestureDetector(
                                onTap: () => context.read<ImageSelectionCubit>().selectImage(index),
                                child: ImageSelectionCard(
                                  image: images[index],
                                  isSelected: index == state,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ],
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