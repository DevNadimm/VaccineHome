import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/asset_paths.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String avatar;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.white,
              backgroundImage: AssetImage(AssetPaths.nadimCorporate),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.white,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    HugeIcons.strokeRoundedCamera02,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryFontColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.verified_rounded,
                color: Colors.blueAccent,
                size: 20,
              ),
            )
          ],
        ),
        Text(
          email,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors.secondaryFontColor,
            ),
          ),
        ),
      ],
    );
  }
}
