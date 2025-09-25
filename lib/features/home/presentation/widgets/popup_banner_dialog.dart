import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/home/data/models/popup_banner_model.dart';
import 'package:vaccine_home/features/home/presentation/blocs/popup_banner/popup_banner_bloc.dart';

class PopupBannerDialog extends StatelessWidget {
  final PopupBannerData banner;

  const PopupBannerDialog({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (banner.image != null && banner.image!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomCachedImage(
                      imageUrl: banner.image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  banner.title ?? "Notice",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, size: 22, color: AppColors.white),
              onPressed: () {
                context.read<PopupBannerBloc>().add(ReadPopupBannerEvent(banner.id ?? 0),);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
