import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/profile/data/models/vaccine_order_model.dart';

class VaccineOrderCard extends StatelessWidget {
  final VaccineOrderData order;

  const VaccineOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final product = order.product;
    final productImage = product?.image ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          // onTap: () {},
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.primaryColor.withOpacity(0.15),
          highlightColor: Colors.transparent,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomCachedImage(
                  imageUrl: productImage,
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product?.name ?? 'Unnamed Vaccine',
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
                      if (product?.price != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "৳ ${product!.price}",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      if ((order.address ?? '').isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "Address: ${order.address}",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryFontColor,
                                height: 1.2,
                              ),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
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
