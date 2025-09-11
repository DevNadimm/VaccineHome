import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';

class SubModuleCard extends StatelessWidget {
  final SubModule subModule;

  const SubModuleCard({
    super.key,
    required this.subModule,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: subModule.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(subModule.icon, size: 24, color: AppColors.primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subModule.title,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subModule.subtitle,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        color: AppColors.secondaryFontColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
