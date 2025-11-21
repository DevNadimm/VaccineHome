import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/vaccine_schedule_model.dart';

class VaccineScheduleCard extends StatelessWidget {
  final Schedule schedule;

  const VaccineScheduleCard({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(
            width: 4,
            color: AppColors.primaryColor,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedVaccine,
                label: 'Vaccine Name',
                text: schedule.vaccineName ?? "No vaccine name set",
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedBaby01,
                label: 'Approximate Age',
                text: schedule.approxAge ?? "No age specified",
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedMedicineBottle02,
                label: 'Route',
                text: schedule.route ?? "No route specified",
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedDroplet,
                label: 'Dose',
                text: schedule.dose ?? "No dose specified",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      schedule.vaccineName ?? "Vaccine Schedule",
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryFontColor,
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryFontColor, size: 20),
        const SizedBox(width: 6),
        Expanded(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.secondaryFontColor,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}