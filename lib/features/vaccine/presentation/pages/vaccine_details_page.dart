import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_product_model.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/image_selection_cubit.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/full_screen_image_page.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/vaccine_order_page.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/image_selection_card.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/vaccine_chip.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/vaccine_info_tile.dart';

class VaccineDetailsPage extends StatelessWidget {
  static Route route(VaccineProduct vaccine) => MaterialPageRoute(builder: (_) => VaccineDetailsPage(vaccine: vaccine));

  final VaccineProduct vaccine;

  const VaccineDetailsPage({super.key, required this.vaccine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Details'),
        leading: AppBarBackBtn(
          onBack: () {
            context.read<ImageSelectionCubit>().reset();
            Navigator.pop(context);
          }
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (vaccine.images != null && vaccine.images!.isNotEmpty)
              ...[
                BlocBuilder<ImageSelectionCubit, int>(
                  builder: (context, state) {
                    final images = vaccine.images ?? [];

                    return Column(
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
                    );
                  },
                ),
              ],
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
              value: '${vaccine.price}',
              icon: HugeIcons.strokeRoundedWallet01,
            ),
            VaccineInfoTile(
              title: 'Recommended Age',
              value: '${vaccine.from} – ${vaccine.to}',
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
                Navigator.push(context, VaccineOrderPage.route(vaccine.id ?? 0));
              },
              child: const Text(
                "Order Now",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
