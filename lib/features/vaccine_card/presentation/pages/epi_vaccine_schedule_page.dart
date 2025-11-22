import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/vaccine_schedule_model.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/vaccine_schedule/vaccine_schedule_bloc.dart';

class EPIVaccineSchedulePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const EPIVaccineSchedulePage());

  const EPIVaccineSchedulePage({super.key});

  @override
  State<EPIVaccineSchedulePage> createState() => _EPIVaccineSchedulePageState();
}

class _EPIVaccineSchedulePageState extends State<EPIVaccineSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EPI Vaccine Schedule'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<VaccineScheduleBloc, VaccineScheduleState>(
        builder: (context, state) {
          if (state is VaccineScheduleLoaded && state.schedules.isNotEmpty) {
            // Find the EPI vaccine schedule
            final epiSchedule = state.schedules.firstWhere((schedule) => schedule.type == 'EPI Vaccine Schedule',
              orElse: () => VaccineScheduleData(type: null, schedules: []),
            );

            // Check if EPI schedule exists and has schedules
            if (epiSchedule.schedules == null || epiSchedule.schedules!.isEmpty) {
              return const EmptyStateWidget(
                title: 'No EPI Vaccines Available',
                message: 'There are no EPI vaccines in the schedule at the moment.',
              );
            }

            return SingleChildScrollView(
              child: _buildVaccinationSection(context, epiSchedule.schedules!),
            );
          } else if (state is VaccineScheduleLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is VaccineScheduleFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Vaccine Schedule',
              message: 'We were unable to fetch the vaccine schedule due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Vaccine Schedule Available',
              message: 'There are no vaccine schedules available at the moment. Please check back later.',
            );
          }
        },
      ),
    );
  }

  Widget _buildVaccinationSection(BuildContext context, List<Schedule> schedules) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHorizontalScrollableTable(context, schedules),
        ],
      ),
    );
  }

  Widget _buildHorizontalScrollableTable(BuildContext context, List<Schedule> schedules) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
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
                  'Swipe right to view more details',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryFontColor,
                    ),
                  ),
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
                      width: 150,
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
                      width: 150,
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
                      width: 100,
                      child: Text(
                        'Age',
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
                      width: 150,
                      child: Text(
                        'Route',
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
                ],
                rows: schedules.map((schedule) => _buildDataRow(schedule)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(Schedule schedule) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 150,
            child: Text(
              schedule.vaccineName ?? "Unknown",
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
            width: 150,
            child: Center(
              child: Text(
                schedule.dose ?? "",
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
            width: 100,
            child: Center(
              child: Text(
                schedule.approxAge ?? "",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryFontColor,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                schedule.route ?? "",
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
