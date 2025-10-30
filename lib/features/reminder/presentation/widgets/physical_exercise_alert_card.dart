import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/helper_functions/date_conversion_helper.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/features/reminder/data/models/physical_exercise_alert_model.dart';

class PhysicalExerciseAlertCard extends StatelessWidget {
  final ExerciseData exercise;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PhysicalExerciseAlertCard({
    super.key,
    required this.exercise,
    this.onEdit,
    this.onDelete,
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
            color: Colors.black.withOpacity(0.04),
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
                icon: HugeIcons.strokeRoundedRunningShoes,
                label: 'Exercise Name',
                text: exercise.exerciseName ?? "No exercise name set",
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedClock01,
                label: 'Duration',
                text: exercise.duration ?? "No duration set",
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedAlarmClock,
                label: 'Time',
                text: TimeConversionHelper.to12Hour(exercise.time ?? ''),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedCalendar03,
                label: 'Start Date',
                text: DateConversionHelper.toDDMMYYYY(exercise.startDate ?? ''),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: HugeIcons.strokeRoundedCalendar03,
                label: 'End Date',
                text: DateConversionHelper.toDDMMYYYY(exercise.endDate ?? ''),
              ),
              const SizedBox(height: 12),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "Physical Exercise Alert",
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

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            label: 'Edit',
            color: AppColors.primaryColor,
            onPressed: onEdit,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            label: 'Delete',
            color: AppColors.error,
            onPressed: onDelete,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color.withOpacity(0.1),
          side: BorderSide(width: 1, color: color),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
