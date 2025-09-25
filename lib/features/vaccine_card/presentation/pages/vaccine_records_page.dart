import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/helper_functions/date_conversion_helper.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/patients_model.dart';

class VaccineRecordsPage extends StatelessWidget {
  static Route route({required Patient patient}) => MaterialPageRoute(
    builder: (_) => VaccineRecordsPage(patient: patient),
  );

  final Patient patient;

  const VaccineRecordsPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final vaccinationCards = patient.vaccinationCard ?? [];
    final completedCount = vaccinationCards.where((card) =>
    card.vaccinationDate != null && card.vaccinationDate!.trim().isNotEmpty).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Records'),
        leading: const AppBarBackBtn(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPatientHeaderCard(),
            _buildStatsSection(vaccinationCards.length, completedCount),
            _buildVaccinationSection(context, vaccinationCards),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientHeaderCard() {
    final patientName = '${patient.firstNameEnglish ?? ''} ${patient.lastNameEnglish ?? ''}'.trim();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName.isNotEmpty ? patientName : 'Unknown Patient',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (patient.uhid != null)
                      Text(
                        'UHID: ${patient.uhid}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (patient.gender != null) ...[
                _buildPatientInfoChip(HugeIcons.strokeRoundedUser, patient.gender!),
                const SizedBox(width: 12),
              ],
              if (patient.birthDate != null)
                _buildPatientInfoChip(HugeIcons.strokeRoundedBirthdayCake, patient.birthDate!),
            ],
          ),
          const SizedBox(height: 12),
          if (patient.updatedAt != null)
            Text(
              'Last Updated: ${DateConversionHelper.fromApiFormat(patient.updatedAt!)}',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPatientInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(int totalVaccines, int completedCount) {
    final pendingCount = totalVaccines - completedCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total',
              totalVaccines.toString(),
              HugeIcons.strokeRoundedVaccine,
              AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Completed',
              completedCount.toString(),
              HugeIcons.strokeRoundedCheckmarkBadge01,
              AppColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Pending',
              pendingCount.toString(),
              HugeIcons.strokeRoundedClock01,
              AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
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
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
                height: 1.2
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVaccinationSection(BuildContext context, List<VaccinationCard> vaccinationCards) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Vaccination History',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryFontColor,
                ),
              ),
            ),
          ),

          vaccinationCards.isEmpty
              ? _buildEmptyState()
              : _buildHorizontalScrollableTable(context, vaccinationCards),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
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
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              HugeIcons.strokeRoundedVaccine,
              size: 48,
              color: AppColors.grey.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No Vaccination Records',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryFontColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This patient has no vaccination history yet.',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalScrollableTable(BuildContext context, List<VaccinationCard> vaccinationCards) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
            child: Row(
              children: [
                const Icon(
                  HugeIcons.strokeRoundedScrollHorizontal,
                  size: 16,
                  color: AppColors.secondaryFontColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Swipe left to view more details',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryFontColor,
                    ),
                  )
                ),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width - 32,
              ),
              child: DataTable(
                columnSpacing: 16,
                horizontalMargin: 16,
                headingRowColor: WidgetStateProperty.all(
                  AppColors.primaryColor,
                ),
                headingRowHeight: 60,
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    color: AppColors.cardColorBold,
                    width: 1,
                  ),
                  verticalInside: BorderSide(
                    color: AppColors.cardColorBold,
                    width: 1,
                  ),
                ),
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 130,
                      child: Text(
                        'Vaccine',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 40,
                      child: Text(
                        'Dose',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 120,
                      child: Text(
                        'Due Date',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 120,
                      child: Text(
                        'Date Given',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                rows: vaccinationCards.map((card) => _buildDataRow(card)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(VaccinationCard card) {
    final bool isCompleted = card.vaccinationDate != null && card.vaccinationDate!.trim().isNotEmpty;
    final Color statusColor = isCompleted ? AppColors.success : AppColors.error;

    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 130,
            child: Text(
              card.vaccineName ?? "Unknown",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryFontColor,
                ),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        DataCell(
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                card.dose ?? "",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 120,
            child: Center(
              child: Text(
                card.dueDate ?? "",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 120,
            child: Center(
              child: Text(
                card.vaccinationDate ?? "",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}