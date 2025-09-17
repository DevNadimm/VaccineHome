import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String greetingText;
  final String userName;
  final String userAvatar;
  final VoidCallback onNotificationTap;

  const HomeAppBar({
    super.key,
    required this.greetingText,
    required this.userName,
    required this.userAvatar,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.cardColorBold,
            backgroundImage: userAvatar.isNotEmpty
                ? CachedNetworkImageProvider('https://vcard.vaccinehomebd.com/storage/app/public/$userAvatar',)
                : null,
            child: userAvatar.isEmpty
                ? const Icon(Icons.person_rounded, size: 22, color: AppColors.white)
                : null,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greetingText,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                )
              ),
              Text(
                userName,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onNotificationTap,
            icon: const Icon(
              HugeIcons.strokeRoundedNotification03,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
