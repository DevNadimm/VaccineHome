import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/asset_paths.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class EmptyNotificationWidget extends StatelessWidget {
  const EmptyNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetPaths.notification,
              height: 200,
            ),
            const SizedBox(height: 32),
            Text(
              'No Notifications!',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryFontColor,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              width: 80,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'You’re all caught up!\nStay tuned — new notifications about your health, vaccines, and reminders will appear here whenever available.',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryFontColor,
                  height: 1.5,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
