import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_product_model.dart';

class VaccineProductCard extends StatelessWidget {
  final VaccineProduct vaccineProduct;

  const VaccineProductCard({super.key, required this.vaccineProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            CustomCachedImage(
              imageUrl: vaccineProduct.image ?? '',
              height: 110,
              width: 110,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vaccineProduct.name ?? 'Unnamed Vaccine',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (vaccineProduct.productType != null)
                          Row(
                            children: [
                              const Icon(
                                HugeIcons.strokeRoundedVaccine,
                                size: 20,
                                color: AppColors.secondaryFontColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${vaccineProduct.productType![0].toUpperCase()}${vaccineProduct.productType!.substring(1)}",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryFontColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (vaccineProduct.gender != null) ...[
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              const Icon(
                                HugeIcons.strokeRoundedUser,
                                size: 20,
                                color: AppColors.secondaryFontColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${vaccineProduct.gender![0].toUpperCase()}${vaccineProduct.gender!.substring(1)}",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryFontColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (vaccineProduct.price != null)
                      Text(
                        "৳ ${vaccineProduct.price}",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
