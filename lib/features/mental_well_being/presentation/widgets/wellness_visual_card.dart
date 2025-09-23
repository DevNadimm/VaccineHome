import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/helper_functions/date_conversion_helper.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';
import 'package:vaccine_home/features/mental_well_being/data/models/mental_well_being_model.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/pages/video_player_page.dart';

class WellnessVisualCard extends StatelessWidget {
  final MentalWellBeingItem visual;

  const WellnessVisualCard({super.key, required this.visual});

  String? _getYoutubeThumbnail(String? url) {
    if (url == null) return null;
    try {
      final uri = Uri.parse(url);
      if (uri.queryParameters.containsKey('v')) {
        final videoId = uri.queryParameters['v'];
        return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
      } else if (uri.pathSegments.isNotEmpty) {
        final videoId = uri.pathSegments.last;
        return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
      }
    } catch (_) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = _getYoutubeThumbnail(visual.youtubeVideoLink);

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
          onTap: () {
            Navigator.push(context, VideoPlayerPage.route(videoUrl: visual.youtubeVideoLink ?? '', videoTitle: visual.title ?? '', publishedDate: DateConversionHelper.fromCustomFormat(visual.createdAt ?? '')));
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.primaryColor.withOpacity(0.15),
          highlightColor: Colors.transparent,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomCachedImage(
                      imageUrl: thumbnailUrl ?? '',
                      height: 87,
                      width: 154,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.primaryColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visual.title ?? 'Untitled Visual',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryFontColor,
                            height: 1.2,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        DateConversionHelper.fromCustomFormat(visual.createdAt ?? ''),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryFontColor,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
