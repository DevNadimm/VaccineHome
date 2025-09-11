import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/features/profile/data/models/profile_menu_item.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<ProfileMenuItem> items;

  const ProfileSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryFontColor,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: Icon(item.icon, color: AppColors.primaryColor),
                      title: Text(
                        item.title,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
                      onTap: item.onTap,
                    ),
                  ),
                  if (index != items.length - 1)
                    const Divider(height: 1, thickness: 0.5, color: Colors.grey),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
